FROM php:8.2-cli

ENV PHP_MEMORY_LIMIT=512M

RUN apt-get update -y && apt-get install -y \
    git \
    libzip-dev \
    unzip \
    libicu-dev \
    libmcrypt-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install intl

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app

CMD bash -c "composer install \
    && vendor/bin/phpstan analyse -c phpstan.neon --memory-limit 1G \
    && vendor/bin/phpunit"
