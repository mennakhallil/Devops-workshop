#!/bin/bash


sudo mkdir -p /var/www/html/website


sudo rm -f /etc/nginx/sites-enabled/default
sudo rm -f /etc/nginx/sites-available/default


sudo bash -c 'cat > /etc/nginx/sites-available/website << EOF
server {
    listen 80;
    server_name _;
    
    root /var/www/html/website;
    index index.html index.htm;
    
    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF'

sudo ln -sf /etc/nginx/sites-available/website /etc/nginx/sites-enabled/website


sudo nginx -t


sudo systemctl restart nginx
sudo systemctl enable nginx

echo "Website deployed successfully!"