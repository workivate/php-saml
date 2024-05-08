FROM php:8.2-cli

ENV PHP_MEMORY_LIMIT=512M

RUN apt-get update -y && apt-get install -y \
    git \
    libzip-dev \
    unzip \
    libicu-dev

RUN docker-php-ext-install pdo_mysql mysqli intl

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN curl -sS https://get.symfony.com/cli/installer | bash

WORKDIR /app

CMD bash -c "composer install \
    && vendor/bin/phpstan analyse -c phpstan.neon --memory-limit 1G \
    && vendor/bin/phpunit"

CMD bash -c "echo 'Hello World'; tail -f /dev/null"
