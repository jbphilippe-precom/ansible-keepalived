#!/bin/bash
RETCODE=0
GW=$(ip route show | grep -i 'default via'| awk '{print $3 }')

function check_ret_code {
if [ $? == 1 ]; then
    logger -p local7.error [Cluster Status] Erreur sur le check du service $1
        exit 1
fi
}

{% if keepalived_with_etcd %}
function check_etcd {
response=$(curl -sL http://{{ keepalived_etcd_addr }}:{{ keepalived_etcd_port }}/health)
if  [ "{\"health\": \"true\"}" != "${response}" ]; then
  return 1
fi
}
{% endif %}

{% if keepalived_service_to_check is defined %}
{% for key, value in keepalived_service_to_check.iteritems() %}
nc -z -w 2 127.0.0.1 {{ value }}
check_ret_code {{ key }}
{% endfor %}
{% endif %}

{% if keepalived_with_etcd %}
check_etcd
check_ret_code etcd
{% endif %}

## Ping Gateway
ping -q -c 3 -i 0.3 -W 1 $GW > /dev/null
check_ret_code PingGateway
