#!/bin/bash

apt update
apt upgrade -y
apt install dante-server
cp /etc/danted.conf /etc/danted.conf-original
git clone https://github.com/ll2Dll/no-auth-socksprox.git
mv no-auth-socksprox/danted.conf /etc/
rm -R no-auth-socksprox
systemctl restart danted
systemctl enable danted
