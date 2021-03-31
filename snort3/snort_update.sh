#!/bin/sh
# Place of storing your Snort rules. Change these variables
# according to your installation.

RULESDIR=/usr/local/etc/rules

# Path to wget program. Modify for your system if needed.
WGETPATH=/usr/bin

# URI for Snort rules
RULESURI=https://www.snort.org/downloads/community/snort3-community-rules.tar.gz

# Get and untar rules.
cd /tmp
rm -rf community-rules
$WGETPATH/wget $RULESURI

tar -zxf snort3-community-rules.tar.gz
rm –f snort3-community-rules.tar.gz

# Copy community rules to rules location
# but frist create a backup if the file exists
if [ -f "/usr/local/etc/rules/snort3-community.rules" ]; then
	cp /usr/local/etc/rules/snort3-community.rules /usr/local/etc/rules/snort3-community.rules_bkp
fi
mv /tmp/snort3-community-rules/snort3-community.rules $RULESDIR

######################################################################
# uncommet the lines bellow to set
# all rules to drop rather than alert
######################################################################

# replace '# alert' to 'drop'
#sed -i "s/# alert/drop/g" /usr/local/etc/rules/snort3-community.rules

# replace 'alert tcp' to 'drop tcp'
#sed -i "s/alert tcp/drop tcp/g" /usr/local/etc/rules/snort3-community.rules

# same as above but for udp
#sed -i "s/alert udp/drop udp/g" /usr/local/etc/rules/snort3-community.rules

# same as above but for icmp
#sed -i "s/alert icmp/drop icmp/g" /usr/local/etc/rules/snort3-community.rules

# remove commente from "# drop" to "drop"
#sed -i "s/# drop/drop/g" /usr/local/etc/rules/snort3-community.rules

