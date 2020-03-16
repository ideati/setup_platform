#!/bin/sh
sudo apt update
sudo apt-get upgrade
sudo apt-get install -y apt-transport-https
sudo apt install -y git build-essential mosh

# nginx web server for serving static files and as proxy server
sudo apt install nginx
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw status
systemctl status nginx
sudo nginx -t
sudo systemctl restart nginx

# Golang
curl -O https://dl.google.com/go/go1.12.9.linux-amd64.tar.gz
sha256sum go1.12.9.linux-amd64.tar.gz 
tar xvf go1.12.9.linux-amd64.tar.gz 
sudo chown -R root:root ./go
sudo mv go /usr/local

# Redis
wget http://download.redis.io/releases/redis-5.0.5.tar.gz
tar xzf redis-5.0.5.tar.gz
cd redis-5.0.5/
ls
make
make test
sudo make install

sudo apt install mosh

# PostgreSQL
sudo apt install postgresql postgresql-contrib

# Pony
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/ponylang/ponyup/latest-release/ponyup-init.sh | sh
ponyup update ponyc nightly
~/.local/share/ponyup/bin/ponyup update ponyc nightly
