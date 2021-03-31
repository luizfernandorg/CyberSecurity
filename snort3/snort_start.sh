#!/bin/bash

##########################################################
# start snort 3
# this way is need to set path for each rules in
# /usr/local/etc/rules/*.rules
# in the ips section
##########################################################
sudo snort -c /usr/local/etc/snort/snort.lua -i wlp2s0b1 -A alert_fast -s 65535 -k none
