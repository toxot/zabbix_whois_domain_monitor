#!/bin/bash
#set -x
zone=`echo $1 | cut -d '.' -f 2`

whoisservofzone=`timeout 10s whois -h whois.iana.org ${zone} | grep 'whois:' | awk '{print $2}'`

expiration_date_raw=`timeout 10s whois -h ${whoisservofzone} $1 | grep 'paid-till\|Registrar Registration Expiration Date\|Registry Expiry Date\|Domain Expiration Date\|Expiration Date' | grep ": "`
expiration_date_raw_test=`timeout 10s whois -h ${whoisservofzone} $1 | grep 'paid-till\|Registrar Registration Expiration Date\|Registry Expiry Date\|Domain Expiration Date\|Expiration Date' | grep ": "| wc -l`
if [[ ${expiration_date_raw_test} -eq 0 ]]; then
    expiration_date_raw=`whois $1 | grep 'paid-till\|Registrar Registration Expiration Date\|Registry Expiry Date\|Domain Expiration Date\|Expiration Date' | grep ": "`
fi
expiration_date=`echo ${expiration_date_raw} | sed -e 's/: /\n/g' | grep -v 'paid-till\|Registrar Registration Expiration Date\|Registry Expiry Date\|Domain Expiration Date\|Expiration Date'`

CURRENTDATE=$(date "+%Y-%m-%d %H:%M:%S")
DAYS_LEFT=$(( ($(date -d "`echo ${expiration_date} | sed -e 's/[a-zA-Z]/ /g'`" +%s) - $(date -d "$CURRENTDATE" +%s) ) / 86400 ))
echo ${DAYS_LEFT}

