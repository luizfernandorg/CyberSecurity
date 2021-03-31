#!/bin/bash


##########################################################
# Create folders
##########################################################
sudo mkdir /usr/local/etc/rules
sudo mkdir /usr/local/etc/so_rules/
sudo mkdir /usr/local/etc/lists/
sudo touch /usr/local/etc/rules/snort.rules
sudo touch /usr/local/etc/rules/local.rules
sudo touch /usr/local/etc/lists/default.blocklist
sudo mkdir /var/log/snort

##########################################################
# generate rule for test
##########################################################
sudo echo "alert icmp any any -> any any ( msg:"ICMP Traffic Detected"; sid:10000001; metadata:policy security-ips alert; )" >> /var/local/etc/rules/local.rules

##########################################################
# Test snort config file and rule
# for now on snort will caputre traffic
# 
# use ctrl+c to stoping it
##########################################################
sudo snort -c /usr/local/etc/snort/snort.lua -R /usr/local/etc/rules/local.rules
sudo snort -c /usr/local/etc/snort/snort.lua -R /usr/local/etc/rules/local.rules \
-i wlp2s0b1 -A alert_fast -s 65535 -k none
