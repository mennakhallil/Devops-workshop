#!/usr/bin/env bash
set -e
read -rp "what's your directory path" dir_path # /home/website
read -rp "what is the backup directory name" backup_name #website
read -rp "what is the path to save backup" backup_path #/home
backup_file="${backup_path}/${backup_name}.tar.gz" #/home/website

if [ ! -d "$dir_path" ]; then
    echo "directory not found"
else
    echo "directory found"
fi

sudo tar -czf "$backup_file" "$dir_path" &> /dev/null
if [ $? -eq 0 ]; then
    echo "backup completed"
else
    echo "problem occured"
fi

sudo du -sh "$backup_file"

echo "simulated email"
echo "to : menah.khalill@gmail.com"
echo "subject : backup completed successfully"
echo " "
echo "backup of directory '$dir_path' completed successfully"
echo "backup file $backup_file"
echo "date: $(date)"
echo " - -------"
