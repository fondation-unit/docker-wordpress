FROM wordpress:6.9.4-php8.5-apache

# Install additional dependencies using predefined $PHPIZE_DEPS variable
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libxml2-dev \
    libxml2 \
    $PHPIZE_DEPS \
    && pecl install solr \
    && docker-php-ext-enable solr \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
