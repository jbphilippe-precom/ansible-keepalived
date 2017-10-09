vrrp_script chk_state {
        script       "{{ keepalived_checkstate_path }}"
        interval 5   # check every 5 seconds
        fall 2       # require 2 failures for KO
        rise 2       # require 2 successes for OK
}

vrrp_instance failover_link {
        state BACKUP
        interface {{ keepalived_interface }}
        virtual_router_id {{ keepalived_virtual_router_id }}
        priority 100
        {% if keepalived_nopreempt %}nopreempt{% endif %}
        
        advert_int 4
        notify {{ keepalived_notify_path }}
        authentication {
                auth_type AH
                auth_pass {{ keepalived_auth_passwd }}
        }
        unicast_src_ip {{ keepalived_backup_ip }}
        unicast_peer {
                {{ keepalived_master_ip }}
        }
        virtual_ipaddress {
                {{ keepalived_vip_ip }}/24 dev {{ keepalived_interface }} label {{ keepalived_interface }}:1
        }
        track_script {
                chk_state
        }
}
