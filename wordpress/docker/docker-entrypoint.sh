#!/bin/sh
set -e

# Create msmtp config with logging
cat > /etc/msmtprc <<EOL
defaults
auth on
tls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile /var/log/msmtp.log

account default
host ${SMTP_HOST}
port ${SMTP_PORT:-587}
user ${SMTP_USER}
password ${SMTP_PASS}
from ${SMTP_USER}
EOL

chmod 644 /etc/msmtprc

# Hand off to the original WordPress entrypoint
exec /usr/local/bin/docker-entrypoint.sh apache2-foreground