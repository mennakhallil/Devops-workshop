#!/bin/bash

read -rp "what is the directory name" massively

if [ -d "$massively" ]; then
    echo "folder exist $massively"
else
    echo "folder not exist $massively"
    sudo mkdir -p $massively
fi

sudo mv "$massively" "/var/www/html/"
download="download"
echo "download template"
sudo wget -O "$download" "https://html5up.net/massively/download"

if [ -f "$download" ]; then
    echo "file exist $download"
    sudo chown ubuntu:ubuntu "$download"
    sudo chmod 777 "$download"
    sudo mv "$download" "/var/www/html/$massively"
    echo "file moved to /var/www/html/$massively"
else
    echo "error :downloading failed,file not exist $download"
    exit 1
fi

sudo sed -i 's|root /var/www/html;|root /var/www/html/massively;|' /etc/nginx/sites-available/default
sudo grep -i "server_name" /etc/nginx/sites-available/default
sudo sed -i 's|server_name .*;|server_name massively.com;|' /etc/nginx/sites-available/default
sudo nginx -t

if [ $? -eq 0 ]; then
    sudo systemctl reload nginx
    echo "nginx updated successfully"
else
    echo "error occured"
fi

echo "127.0.0.1 massively.com" >> /etc/hosts | head
cat /etc/hosts

URL="http://massively.com"

if curl -s --head "$URL" >/dev/null; then
    echo "$URL works successfully"
else
    echo "$URL doesnot work"
    exit 1
fi

status=$(curl -o /dev/null -s -w "%{http_code}" "$URL")

if [ "$status" -eq 200 ]; then
    echo "connection is ok"
else
    echo "failed to connect"
fi

curl -I http://massively.com
