#!/bin/bash
sudo apt-get update -y
sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
echo "hello user! > /var/www/html/index.html"


