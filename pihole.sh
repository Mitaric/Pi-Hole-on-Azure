#!/bin/bash
#DNS Configurations
CONF_DNS1=8.8.8.8
CONF_DNS2=8.8.4.4

#System Updates
apt update
apt upgrade -y
apt autoremove -y
apt autoclean -y

#Pre-Requisites
apt install curl -y

#Collect System Information
DEVICE_IFACE=$(ip route get 8.8.8.8 | awk '{print $5}')
DEVICE_IPV4=$(ip route get 8.8.8.8 | awk '{print $7}')

#Setup Automated Install Configurations
rm /etc/pihole/setupVars.conf
mkdir -p /etc/pihole
touch /etc/pihole/setupVars.conf
echo "DNSMASQ_LISTENING=single" > /etc/pihole/setupVars.conf
echo "DNS_FQDN_REQUIRED=true" >> /etc/pihole/setupVars.conf
echo "DNS_BOGUS_PRIV=true" >> /etc/pihole/setupVars.conf
echo "DNSSEC=false" >> /etc/pihole/setupVars.conf
echo "BLOCKING_ENABLED=true" >> /etc/pihole/setupVars.conf
echo "PIHOLE_INTERFACE=$DEVICE_IFACE" >> /etc/pihole/setupVars.conf
echo "IPV4_ADDRESS=$DEVICE_IPV4" >> /etc/pihole/setupVars.conf
echo "IPV6_ADDRESS=" >> /etc/pihole/setupVars.conf
echo "PIHOLE_DNS_1=$CONF_DNS1#53" >> /etc/pihole/setupVars.conf
echo "PIHOLE_DNS_2=$CONF_DNS2#53" >> /etc/pihole/setupVars.conf
echo "QUERY_LOGGING=true" >> /etc/pihole/setupVars.conf
echo "INSTALL_WEB_SERVER=true" >> /etc/pihole/setupVars.conf
echo "INSTALL_WEB_INTERFACE=true" >> /etc/pihole/setupVars.conf
echo "LIGHTTPD_ENABLED=true" >> /etc/pihole/setupVars.conf
echo "WEBPASSWD=" >> /etc/pihole/setupVars.conf

#Download and Install
curl -sSL https://install.pi-hole.net -o install-pihole.sh
chmod +x install-pihole.sh
./install-pihole.sh --unattended
rm install-pihole.sh

#Disable Web Password
echo | pihole -a -p
