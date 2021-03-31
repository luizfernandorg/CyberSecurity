# CyberSecurity
Sharing some scripts, settings and firewall Rules

# Snort 3 
I created three scripts, as follows:

# download and install dependencies and snort
snort_install.sh

# download commuity rules for snort 3
snort_update.sh

# finally execute snort
# but before start
# is better to set network or ip as HOME_NET
# and then set EXTERNAL_NET="!HOME_NET"
# in the file /usr/local/etc/snort/snort.lua
snort_start.sh

execute scripts in that order from top to bottom
each scripts has comments to give orientations
