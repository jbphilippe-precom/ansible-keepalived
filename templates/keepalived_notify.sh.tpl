#!/bin/bash
TYPE=$1
NAME=$2
STATE=$3

echo $STATE > /var/run/keepalived.state

case $STATE in
        "MASTER")
                  exit 0
                  ;;
        "BACKUP")
                  exit 0
                  ;;
        "FAULT")  
                  exit 0
                  ;;
        *)        echo "unknown state"
                  exit 1
                  ;;
esac
