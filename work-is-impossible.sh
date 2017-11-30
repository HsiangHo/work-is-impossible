begin=$(expr $(cat ./begin) + 86400) # init: 1468944000
end=$(date '+%s')

list=$(seq -f "%.0f" $begin 86400 $end)

for i in $list
do
    days=$((($i - $begin) / 86400 + 1 ))
    date -r $(expr $i) +"%Y年%m月%d日:　　继续打工！　　已打工${days}天  " >> ./README.md
    echo $i > ./begin
done
