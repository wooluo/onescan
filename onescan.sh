#!/bin/bash

echo "OneScan v1.0"
echo "请严格遵守网络安全法，请对你的漏洞扫描行为负责，亲~"
echo "例如输入子域名：vulnweb.com "
read -t 10 -p "请输入要漏洞扫描的根域名：" url
# echo "准备中..."
i=0
str=""
arr=("|" "/" "-" "\\")
while [ $i -le 20 ]
do
  let index=i%4
  let indexcolor=i%8
  let color=30+indexcolor
  let NUmbER=$i*5
  printf "\e[0;$color;1m[%-20s][%d%%]%c\r" "$str" "$NUmbER" "${arr[$index]}"
  sleep 0.1
  let i++
  str+='+'
done
printf "\n"
printf "正在执行查找子域名...稍候！"
printf "\n"
echo "***以下是找到的子域名："

./subfinder -d $url -silent | tee ./b.txt


#更改根域名，可以更改输出文件
#./httpx -status-code -title -tech-detect -list b.txt |tee ./ur.txt

printf "\n"
printf "正在执行探测web网址存活...稍候！"
printf "\n"
./httpx -list b.txt |tee ./ur.txt


echo "子域名结果保存到当前文件夹内的 ur.txt"


#read -t 10 -p "请输入要爬取根域名：" cookie
printf "\n"
printf "正在执行web漏洞扫描...稍候！"
printf "\n"
./nuclei -l ur.txt |tee sec.txt
