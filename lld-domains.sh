#!/bin/bash
excludelist="/etc/zabbix/scripts/lld-domains-exclude.list"
echo "{ \"data\":["
z=0
for i in `ls /var/named/*.db | sed -e 's/\/var\/named\///g' | sed -e 's/\.db//g'` ; do
        if [ -f ${excludelist} ] ; then
                checkexclude=`cat ${excludelist} | grep ${i} | wc -l`
        else
                checkexclude="0"
        fi
        if [ "${checkexclude}" -eq "0" ] ; then
                k=""
                if [ "${z}" -ne "0" ] ; then
                        k=","
                fi
                echo "${k}{\"{#DOMAINNAME}\":\"${i}\"}"
                z=$(( z + 1 ))
        fi
done
echo ] }

