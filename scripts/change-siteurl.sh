#!/usr/bin/env bash
set -euo pipefail

DB_CONTAINER="db"

: "${MARIADB_DATABASE:?missing MARIADB_DATABASE}"
: "${MARIADB_USER:?missing MARIADB_USER}"
: "${MARIADB_PASSWORD:?missing MARIADB_PASSWORD}"
: "${WORDPRESS_TABLE_PREFIX:?missing WORDPRESS_TABLE_PREFIX}"
: "${DOMAIN_NAME:?missing DOMAIN_NAME}"

SQL="
UPDATE ${WORDPRESS_TABLE_PREFIX}options SET option_value='${DOMAIN_NAME}' WHERE option_name='home';
UPDATE ${WORDPRESS_TABLE_PREFIX}options SET option_value='${DOMAIN_NAME}' WHERE option_name='siteurl';
"

docker exec -i "$DB_CONTAINER" mariadb \
  -uroot \
  "$MARIADB_DATABASE" \
  -e "$SQL"
