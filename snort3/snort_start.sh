#!/bin/bash

##########################################################
# start snort 3
# this way is need to set path for each rules in
# /usr/local/etc/rules/*.rules
# there is a example of snort.lua in this repository
# in the folter snort3
#
# should update HOME_NET
# and include path to each rule, in the ips section
##########################################################
sudo snort -c /usr/local/etc/snort/snort.lua -i eth0 -A alert_fast -s 65535 -k none
