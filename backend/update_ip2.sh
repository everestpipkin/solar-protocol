#!/bin/sh

# This script is run from solarProtocol.py

# Variables
LAST_IP_FILE=/tmp/lastip.txt
LOGFILE=/var/log/namecheap.log
TIME="`date +%Y-%m-%d:%H:%M`"
HOST=@
DOMAIN=solarprotocol.net

#the DNS password is passed as an argument from solarProtocol.py
PASSWORD=$1	
echo "TIME: $TIME"

# Grab last IP
#LAST_IP=`cat $LAST_IP_FILE`
#echo "LAST IP: $LAST_IP"

# Get current IP
IP="`wget --no-check-certificate -qO - https://dynamicdns.park-your-domain.com/getip`"
echo "CURRENT IP: $IP"

# Check if IP has changed
# if [ "$IP" = "$LAST_IP" ]; then
#     echo "IP has not changed"
#     echo "Exiting"
#     exit 1
# fi

# Update Namecheap DDNS via DNA gateway at dns.solarprotocol.net
#URL="wget --no-check-certificate -qO - https://dynamicdns.park-your-domain.com/update?host=$HOST&domain=$DOMAIN&password=$PASSWORD&ip=$IP"

#get request
#URL="wget --no-check-certificate -qO - http://dns.solarprotocol.net/index.php?ip=$IP&key=$PASSWORD"

#post request
#URL="wget --post-data 'key=$PASSWORD&ip=$IP'  http://dns.solarprotocol.net"

#with CURL
URL="curl -X POST -F 'key=$PASSWORD' -F 'ip=$IP'  http://dns.solarprotocol.net"

echo $URL

RESPONSE=$($URL)
echo "Response:"
echo $RESPONSE

# Save the current IP as the last IP
# echo "$IP" >> $LAST_IP_FILE

# Log the time and IP
echo "$TIME - $IP" >> $LOGFILE
