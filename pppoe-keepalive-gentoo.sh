#!/bin/bash

/bin/ping -c 1 google.com > /dev/null 2>&1
if [ "$?" -ne 0 ]; then
    echo "--"
    /etc/init.d/net.ppp0 restart
    echo `date +%D" "%H:%M:%S`" - ADSL re-connected.  "
    echo "--"
    exit 0
fi
