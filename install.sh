#!/bin/bash

# Update & Upgrade
apt update
apt upgrade -y
# Install
apt install dante-server
# Configure
cp /etc/danted.conf /etc/danted-org.conf
mv quick-socksprox/danted-noauth.conf /etc/danted.conf
# Admin
## Port
echo "What port number should be used?:"
read portnumber
sed -i "s/\bnewport\b/${portnumber}/g" /etc/danted.conf
# Tidyup
rm -R quick-socksprox
# Restart
systemctl restart danted
systemctl enable danted
echo "//////////////////////////"
echo "The proxy IP and port is:"
curl ifconfig.me && echo ":"$portnumber
echo "//////////////////////////"
