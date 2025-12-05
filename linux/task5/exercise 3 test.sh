#!/usr/bin/env bash

echo "Backup started at $(date)"
sudo mkdir -p "/backup"
sudo chmod +x "/backup"
sudo touch "/var/log/backup.log"
sudo chmod +x "/var/log/backup.log"
date=$(date +%Y-%m-%d)
weekday=$(date +%u)

read -rp "What is the backup file" backup_file # /backup/website.tar.gz
read -rp "What is the backup source" backup_source # /home/website
read -rp "What is the log file " log_file # /var/log/backup.log
read -rp "What is the backup des" backup_Des # /backup

if [ "$weekday" -eq 7 ]; then
    echo "[$date]weekly backup is created " >> "$log_file"
   if sudo tar -czvf "$backup_file" "$backup_source" >> "$log_file" 2>&1 ; then
    echo "[$date] weekly backup completed successfully " >> "$log_file"
   else
    echo "weekly backup failed" >> "$log_file"
   fi

else
    echo "Daily backup is created " >> "$log_file"
    if sudo tar -czvf "$backup_file" --newer-mtime="1 day ago" "$backup_source" >> "$log_file" 2>&1 ;then
       echo "daily backup completed successfully"
   else 
       echo "daily backup failed"
   fi
fi
if [ $? -eq 0 ]; then
        echo "backup created successfully" 
else
        echo "backup failed"
fi

sudo find "$backup_Des" -name "*.tar.gz" -type f -mtime +30 -exec rm {} \;

echo "simulated email"
echo "mail to menah.khill@gmail.com"
echo "subject:Backup completed successfully on $(date)"
echo "backup file: $backup_file"
