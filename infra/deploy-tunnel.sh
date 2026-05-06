#!/bin/bash
set -a
source .env
set +a

envsubst < solr-tunnel.service.template > /etc/systemd/system/solr-tunnel.service
systemctl daemon-reload
systemctl enable solr-tunnel
systemctl restart solr-tunnel
