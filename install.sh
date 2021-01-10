#!/bin/bash

# Update & Upgrade
apt update
apt upgrade -y
# Install
apt install dante-server
# Configure
cp /etc/danted.conf /etc/danted-org.conf
cp quick-socksprox/danted.conf /etc/

# Admin
## Port
echo "//////////////////////////"
read -r -p "What port number should be used? (>1024): " portnumber
sed -i "s/\bnewport\b/${portnumber}/g" /etc/danted.conf
## Users Auth
read -r -p "Do you want to use authentication? [Y/n]: " auth
case $auth in
        [yY][eE][sS]|[yY])
        sed -i 's/setauth/username/' /etc/danted.conf
	read -r -p "Enter Username: " username
	read -r -p "Enter Password: " passwd
	sudo useradd --shell /usr/sbin/nologin $username
	echo $username:$passwd | chpasswd
        ;;
        [nN][oO]|[nN])
        sed -i 's/setauth/none/' /etc/danted.conf
	username=N/A
	passwd=N/A
        ;;
esac

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
