FROM composer:2 AS plugins-builder

WORKDIR /app

COPY ./src/wp-content/plugins ./wp-content/plugins
COPY ./docker/build-plugins.sh /usr/local/bin/build-plugins.sh

RUN chmod +x /usr/local/bin/build-plugins.sh \
    && build-plugins.sh

FROM wordpress:7.0.0-php8.5-apache

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libxml2-dev \
    libxml2 \
    $PHPIZE_DEPS \
    msmtp msmtp-mta mailutils \
    && pecl install solr \
    && docker-php-ext-enable solr \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./src /var/www/html

COPY --from=plugins-builder \
    /app/wp-content/plugins \
    /var/www/html/wp-content/plugins

COPY ./docker/docker-entrypoint.sh /usr/local/bin/custom-entrypoint.sh

RUN chmod +x /usr/local/bin/custom-entrypoint.sh

ENTRYPOINT ["custom-entrypoint.sh"]