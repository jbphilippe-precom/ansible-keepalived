Role Name
=========

    Deploy Keepalived Master and Backup (two nodes and one vip)
    Deploy Keepalived Multi - Master And Backup (three nodes and two vip)

Requirements
------------

    Ansible 2.x

Role Variables
--------------

    ## APT ##
    keepalived_apt_repo: "deb http://mirror.services.local/keepalived/ubuntu trusty main"
    keepalived_apt_key: "http://mirror.services.local/pubkey/keepalived.gpg.pub"

    ## Configuration ##
    keepalived_interface: eth0
    keepalived_virtual_router_id: 42
    keepalived_virtual_router_id_vip1: 21
    keepalived_virtual_router_id_vip2: 42

    ## template ##
    ## 2 nodes 1 vip ##
    keepalived_backup_conf: "keepalived_backup.conf.tpl"
    keepalived_checkstate: "keepalived_checkstate.sh.tpl"
    keepalived_master_conf: "keepalived_master.conf.tpl"
    keepalived_notify: "keepalived_notify.sh.tpl"
    keepalived_profile: "keepalived_profile.sh.tpl"

    ## 2 nodes 2 vip ##
    keepalived_interface_vip1: eth0
    keepalived_interface_vip2: eth1
    keepalived_master_two_nodes_two_vip_conf: "keepalived_master_two_nodes_two_vip.conf.tpl"
    keepalived_backup_two_nodes_two_vip_conf: "keepalived_backup_two_nodes_two_vip.conf.tpl"
    keepalived_profile_two_vip: "keepalived_profile_two_vip.sh.tpl"

    ## 3 nodes 2 vip ##
    keepalived_master_vip1_conf: "keepalived_master_vip1.conf"
    keepalived_master_vip2_conf: "keepalived_master_vip2.conf"
    keepalived_backup_three_nodes_conf: "keepalived_backup_three_nodes.conf.tpl"
    keepalived_notify_vip1: "keepalived_notify_vip1.sh.tpl"
    keepalived_notify_vip2: "keepalived_notify_vip2.sh.tpl"
    keepalived_profile_vip1: "keepalived_profile_vip1.sh.tpl"
    keepalived_profile_vip2: "keepalived_profile_vip2.sh.tpl"
    keepalived_profile_backup_three_nodes: "keepalived_profile_backup_three_nodes.sh.tpl"

    ## DEST PATH ##
    keepalived_config_path: "/etc/keepalived/keepalived.conf"
    keepalived_checkstate_path: "/usr/local/sbin/check_state_keep.sh"
    keepalived_notify_path: "/usr/local/sbin/notify-keepalived.sh"
    keepalived_profile_path: "/etc/profile.d/keepalived_status.sh"
    keepalived_notify_path_vip1: "/usr/local/sbin/notify-keepalived_vip1.sh"
    keepalived_notify_path_vip2: "/usr/local/sbin/notify-keepalived_vip2.sh"

    keepalived_service_name: "keepalived"

    keepalived_two_nodes: False
    keepalived_three_nodes: False
    keepalived_two_nodes_two_vip: False
    keepalived_vip1: False
    keepalived_vip2: False
    keepalived_master: False
    keepalived_nopreempt: True

    ## Check quorum with etcd ##
    keepalived_with_etcd: False
    keepalived_etcd_port : 2379

    keepalived_service_to_check: {keepalivedapi: 12900 , keepalived: 9000}
    keepalived_auth_passwd: "MonSuperb3PassWd"
    keepalived_master_ip: "192.168.229.13"
    keepalived_backup_ip: "192.168.229.18"
    keepalived_vip_ip: "192.168.229.79"

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook Two nodes - 1 VIP
----------------------------------------

    - hosts: graylogserver
      become: yes
      roles:
        - { role: ansible-keepalived }
      vars:
        keepalived_service_to_check: {keepalivedapi: 12900 , keepalived: 9000}
        keepalived_auth_passwd: "OseFDuPassWd"
        keepalived_master_ip: "192.168.229.13"
        keepalived_backup_ip: "192.168.229.18"
        keepalived_vip_ip: "192.168.229.79"
        keepalived_interface: "eth1"

Example Playbook Three nodes - 2 VIP
----------------------------------------
    - hosts: graylogserver
      become: yes
      roles:
        - { role: ansible-keepalived }
      vars:
        keepalived_service_to_check: {graylogapi: 12900 , graylogkeepalived: 9000}
        keepalived_auth_passwd: "OseFDuPassWd"
        keepalived_interface: "eth1"
        keepalived_master_ip_vip1: "192.168.229.13"
        keepalived_master_ip_vip2: "192.168.229.18"
        keepalived_backup_ip: "192.168.229.103"
        keepalived_vip1_ip: "192.168.229.79"
        keepalived_vip2_ip: "192.168.229.58"
        keepalived_three_nodes: yes

Example Playbook Three nodes - 2 VIP with ETCD Health's check
----------------------------------------------------------------
    - hosts: graylogserver
      become: yes
      roles:
        - { role: ansible-keepalived }
      vars:
        keepalived_service_to_check: {graylogapi: 12900 , graylogkeepalived: 9000}
        keepalived_auth_passwd: "OseFDuPassWd"
        keepalived_interface: "eth1"
        keepalived_master_ip_vip1: "192.168.229.13"
        keepalived_master_ip_vip2: "192.168.229.18"
        keepalived_backup_ip: "192.168.229.103"
        keepalived_vip1_ip: "192.168.229.79"
        keepalived_vip2_ip: "192.168.229.58"
        keepalived_three_nodes: yes
        keepalived_with_etcd: True

Example Playbook Two nodes - 2 VIP
----------------------------------------------------------------
    - hosts: graylogserver
      become: yes
      roles:
        - { role: ansible-keepalived }
      vars:
        keepalived_service_to_check: {graylogapi: 12900 , graylogkeepalived: 9000}
        keepalived_auth_passwd: "OseFDuPassWd"
        keepalived_two_nodes_two_vip: True
        keepalived_master_ip_vip1: "192.168.100.112"
        keepalived_master_ip_vip2: "192.168.229.112"
        keepalived_backup_ip_vip1: "192.168.100.252"
        keepalived_backup_ip_vip2: "192.168.229.252"
        keepalived_vip1_ip: "192.168.229.186"
        keepalived_vip2_ip: "192.168.229.75"
        keepalived_interface_vip1: "eth0"
        keepalived_interface_vip2: "eth1"

Example of inventory two nodes - 1 vip
-----------------------------------------
    [graylogserver]
    jlsgraylog01l.btsys.local keepalived_master=True
    jlsgraylog02l.btsys.local keepalived_master=False

Example of inventory three nodes - 2 vips
-----------------------------------------
    [graylogserver]
    jlsgraylog01l.btsys.local keepalived_master=True keepalived_vip1=True
    jlsgraylog02l.btsys.local keepalived_master=True keepalived_vip2=True
    jlsgraylog03l.btsys.local keepalived_master=False

Example of inventory two nodes - 2 vip
-----------------------------------------
    [graylogserver]
    jlsgraylog01l.btsys.local keepalived_master=True keepalived_vip1=True keepalived_vip2=True
    jlsgraylog02l.btsys.local keepalived_master=False
