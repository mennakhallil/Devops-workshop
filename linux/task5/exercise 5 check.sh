#!/usr/bin/env bash

logfile="/var/log/logfile"
yes > /dev/null &
jobs
$pid=$!
echo "$pid"
echo "cpu_usage: $(ps aux | grep " $pid " | awk '{print $3}' )" >> $logfile

sudo fallocate -l 1G /home/test1
sudo fallocate -l 1G /home/test2
sudo fallocate -l 1G /home/test3

df -h /home
echo "disk usage: $(df /home | tail -1 | awk '{print $5}' )" >> $logfile
sudo mv -f "/etc/resolv.comf" "/etc/resolv.conf.backup"
sudo ls -la "/etc/resolv.conf.back"
ping google.com
######################
echo "to solve cpu usage"
sudo killall "$pid"
ps aux | awk '{print $3}' >> $logfile
######################
echo "to solve disk usage issue"
sudo rm -rf "/home/test1"
df -h /home
######################
echo "to solve network issue"
sudo mv -f "/etc/resolv.conf.backup" "/etc/resolv.conf"
sudo ls -la /etc/resolv.conf
