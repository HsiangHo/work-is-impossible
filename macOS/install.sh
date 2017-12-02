SOURCE="$0"
while [ -h "$SOURCE"  ]; do # resolve $SOURCE until the file is no longer a symlink
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
SOURCE="$(readlink "$SOURCE")"
[[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
userName=$(stat -f '%Su' /dev/console)
LaunchAgent="/Library/LaunchAgents/com.hsiangho.work-is-impossible.plist"
workPath=$( dirname "$DIR"  )
shellPath=$workPath"/work-is-impossible.sh"
tmpLaunchAgent=$DIR/com.hsiangho.work-is-impossible.plist

plutil -replace WorkingDirectory -string "$workPath" "$tmpLaunchAgent"
plutil -replace ProgramArguments -xml "<array><string>$shellPath</string></array>" "$tmpLaunchAgent"

if [ -a "$LaunchAgent" ]; then
sudo -u "$userName" launchctl unload "$LaunchAgent"
rm -rf "$LaunchAgent"
fi

if [ -a "$tmpLaunchAgent" ]; then
cp -rp "$tmpLaunchAgent" "$LaunchAgent"
fi

if [ -a "$LaunchAgent" ]; then
chown root "$LaunchAgent"
chgrp wheel "$LaunchAgent"
chmod 644 "$LaunchAgent"
fi

if [ -a "$LaunchAgent" ]; then
sudo -u "$userName" launchctl load "$LaunchAgent"
fi
