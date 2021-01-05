#!/bin/bash

# Update & Upgrade
apt update
apt upgrade -y
# Install
apt install dante-server
# Configure
cp /etc/danted.conf /etc/danted-org.conf
mv quick-socksprox/danted-auth.conf /etc/danted.conf
# Admin
## Port
echo "//////////////////////////"
echo "What port number should be used? (>1024):"
read portnumber
sed -i "s/\bnewport\b/${portnumber}/g" /etc/danted.conf
## Users Auth
echo "Enter Username:"
read username
echo "Enter Password:"
read passwd
sudo useradd --shell /usr/sbin/nologin $username
echo $username:$passwd | chpasswd
#sed -i "s/\bnewuser\b/${username}/g" /etc/danted.conf (use for all-in-one-script)
# Tidyup
rm -R quick-socksprox
# Restart
systemctl restart danted
systemctl enable danted
clear
echo "//////////////////////////"
echo "//////SETUP COMPLETE//////"
echo "//////////////////////////"
echo -n "Proxy: "
curl ifconfig.me
echo ""
echo "Port:" $portnumber
echo "Username:" $username
echo "Password:" $passwd
echo "//////////////////////////"
