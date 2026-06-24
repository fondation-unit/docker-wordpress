#!/usr/bin/env bash
set -euo pipefail

# Generic script:
find wp-content/plugins -mindepth 1 -maxdepth 1 -type d | while read -r dir
do
    if [ -f "$dir/composer.json" ]; then
        echo "Installing dependencies for $dir"
        composer install \
            --working-dir="$dir" \
            --no-dev \
            --optimize-autoloader \
            --no-interaction
    fi
done

# Case with broken monorepo plugins
# for dir in wp-content/plugins/*; do
#   if [ -f "$dir/composer.json" ]; then

#     case "$dir" in
#       *plugin-folder-name*)
#         echo "Skipping broken monorepo: $dir"
#         continue
#         ;;
#     esac

#     echo "Installing dependencies for: $dir"

#     composer install \
#       --working-dir="$dir" \
#       --no-dev \
#       --optimize-autoloader \
#       --no-interaction
#   fi
# done
