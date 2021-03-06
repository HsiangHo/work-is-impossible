#!/bin/sh
init=1468944001
begin=$(expr $(cat ./begin) + 86400)
end=$(date '+%s')

list=$(seq -f "%.0f" $begin 86400 $end)
after=''

for i in $list
do
    days=$((($i - $init) / 86400 + 1 ))
    date -r $(expr $i) +"%Y年%m月%d日:　　继续打工！　　已打工${days}天  " >> ./README.md
    echo $i > ./begin

    git add ./README.md
    git add ./begin
    git commit --date=$i --message='add'

    after='git push origin HEAD'
done

eval $after
