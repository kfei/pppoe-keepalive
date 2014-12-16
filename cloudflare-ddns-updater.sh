#!/bin/sh
#
# Usage: ./cloudflare-ddns-updater.sh <API KEY> <USER MAIL> <HOST NAME>

CFKEY=$1
CFUSER=$2
CFHOST=$3
 
EXTIP=""
OLDIP=""

type dig &>/dev/null && {
    EXTIP=$(dig +short myip.opendns.com @resolver1.opendns.com)
}

[ ! "$EXTIP" ] && type curl &>/dev/null && {
    EXTIP=$(curl -s http://icanhazip.com)
}

[ "$EXTIP" ] || {
    echo "Neither curl nor dig is installed."
    exit 1
}

[ -f /tmp/.extip ] && {
    OLDIP=$(cat /tmp/.extip)
}

[ "$EXTIP" = "$OLDIP" ] || {
    echo $EXTIP > /tmp/.extip
    printf "Updating CloudFlare: $CFHOST -> $EXTIP ... "
    curl -s https://www.cloudflare.com/api.html?a=DIUP\&hosts="$CFHOST"\&u="$CFUSER"\&tkn="$CFKEY"\&ip="$EXTIP" &> /dev/null
    [ $? ] && echo "OK!"
}
