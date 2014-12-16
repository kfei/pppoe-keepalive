#!/bin/bash

/bin/ping -c 1 google.com > /dev/null 2>&1

if [ "$?" -ne 0 ]; then
    echo "--"
    if [ -f /etc/gentoo-release ];
    then
        # Kind of hardcoded just for my Gentoo boxes
        /etc/init.d/net.ppp0 restart
    else
        # Kind of hardcoded just for my Ubuntu boxes
        /etc/init.d/networking restart
    fi
    echo `date +%D" "%H:%M:%S`" - ADSL re-connected.  "
    echo "--"
    exit 0
fi
