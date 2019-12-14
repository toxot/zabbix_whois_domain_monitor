# zabbix_whois_domain_monitor
Zabbix trapper to monitoring domains expiration period


Usage:
This script should run on dns servers, or hosting servers with dns functions (for example)  it parse list of domains (u can exclude some of this domains), after it push each domain expiration period in day to zabbix server that configured in your /etc/zabbix/zabbix_agent.conf

