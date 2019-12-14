#!/bin/bash
zs="/usr/bin/zabbix_sender"
zconfig="/etc/zabbix/zabbix_agentd.conf"
excludelist="/etc/zabbix/scripts/lld-domains-exclude.list"
monhost="HOSTNAME"
for i in `ls /var/named/*.db | sed -e 's/\/var\/named\///g' | sed -e 's/\.db//g'` ; do
        if [ -f ${excludelist} ] ; then
                checkexclude=`cat ${excludelist} | grep ${i} | wc -l`
        else
                checkexclude="0"
        fi
        if [ "${checkexclude}" -eq "0" ] ; then
                expdays=`/etc/zabbix/scripts/domain-exp-check.sh ${i}`
                timeout 5s ${zs} -c ${zconfig} -s ''"${monhost}"'' -k domain-expiration-check[${i}] -o ${expdays} 2>&1 > /dev/null
                sleep 5
        fi
done
timeout 5s ${zs} -c ${zconfig} -s ''"${monhost}"'' -k domain_exp_time_ping -o 1 2>&1 > /dev/null

