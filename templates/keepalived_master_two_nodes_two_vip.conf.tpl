vrrp_script chk_state {
        script       "{{ keepalived_checkstate_path }}"
        interval 5   # check every 5 seconds
        fall 2       # require 2 failures for KO
        rise 2       # require 2 successes for OK
}

vrrp_instance VIP1 {
        state MASTER
        interface {{ keepalived_interface_vip1 }}
        virtual_router_id {{ keepalived_virtual_router_id_vip1 }}
        priority 101
        {% if keepalived_nopreempt %}nopreempt{% endif %}

        advert_int 4
        notify {{ keepalived_notify_path_vip1 }}
        authentication {
                auth_type AH
                auth_pass {{ keepalived_auth_passwd }}
        }
        unicast_src_ip {{ keepalived_master_ip_vip1 }}
        unicast_peer {
                {{ keepalived_backup_ip_vip1 }}
        }
        virtual_ipaddress {
                {{ keepalived_vip1_ip }}/24 dev {{ keepalived_interface_vip1 }} label {{ keepalived_interface_vip1 }}:1
        }
        track_script {
                chk_state
        }
}

vrrp_instance VIP2 {
        state MASTER
        interface {{ keepalived_interface_vip2 }}
        virtual_router_id {{ keepalived_virtual_router_id_vip2 }}
        priority 101
        {% if keepalived_nopreempt %}nopreempt{% endif %}

        advert_int 4
        notify {{ keepalived_notify_path_vip2 }}
        authentication {
                auth_type AH
                auth_pass {{ keepalived_auth_passwd }}
        }
        unicast_src_ip {{ keepalived_master_ip_vip2 }}
        unicast_peer {
                {{ keepalived_backup_ip_vip2 }}
        }
        virtual_ipaddress {
                {{ keepalived_vip2_ip }}/24 dev {{ keepalived_interface_vip2 }} label {{ keepalived_interface_vip2 }}:2
        }
        track_script {
                chk_state
        }
}
