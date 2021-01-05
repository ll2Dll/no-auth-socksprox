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
echo "//////////////////////////"
echo "What port number should be used? (>1024):"
read portnumber
sed -i "s/\bnewport\b/${portnumber}/g" /etc/danted.conf
# Tidyup
rm -R quick-socksprox
# Restart
systemctl restart danted
systemctl enable danted
echo "//////////////////////////"
echo "//////SETUP COMPLETE//////"
echo "//////////////////////////"
echo -n "Proxy: "
curl ifconfig.me
echo ""
echo "Port:" $portnumber
echo "//////////////////////////"
