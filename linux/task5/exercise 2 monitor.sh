#! usr/bin/env bash
df / | awk -F ' ' '{print $5}'
logfile="/var/log/logfile"
echo "disk_usage: $( df / | tail -1 | awk -F ' ' '{print $5}' )" >> $logfile
if [ $disk_usage -gt 80 ]; then
    echo "$date disk usage is more than 80 %" >> $logfile
else
    echo "disk usage is normal " >> $logfile
fi

####################
echo "mem_usage: $( free -h | grep -i 'mem' | awk '{print int($3 / $2 *100)}' )"

if [ $mem_usage -gt 90 ]; then
    echo "$date memory usage is more than 90 % " >> $logfile
else
    echo "memory usage is normal " >> $logfile
fi
##################
echo "cpu_load: $( uptime | grep -i 'load average' | awk -F ' ' '{print $9}' )"

if [ $cpu_load -gt 0.5 ]; then
    echo "$date cpu load average is more than 0.5 " >> $logfile
else
    echo "cpu load is normal " >> $logfile
fi


