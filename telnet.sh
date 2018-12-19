#!/bin/bash
yum install telnet-server telnet
# configure firewall
firewall-cmd --add-service=telnet --zone=public
firewall-cmd --add-service=telnet --zone=public --permanent
# enable telnet
echo "disable = no" > /etc/xinetd.d/telnet
# restart telnet
systemctl start telnet.socket
systemctl enable telnet.socket
