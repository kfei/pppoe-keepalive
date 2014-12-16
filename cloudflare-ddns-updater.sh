#!/bin/sh
#
# Usage: ./cloudflare-ddns-updater.sh <APIKEY> <USERMAIL> <HOSTNAME(s)>

CFKEY=$1
CFUSER=$2
CFHOSTS="$(sed 's/,\+/ /g' <<<"$3")"
 
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
    for h in $CFHOSTS ; do
        printf "Updating CloudFlare: $h -> $EXTIP ... "
        curl -s https://www.cloudflare.com/api.html?a=DIUP\&hosts="$h"\&u="$CFUSER"\&tkn="$CFKEY"\&ip="$EXTIP"
    done
}
