FROM php:8.2-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    zlib1g-dev \
    libzip-dev \
    libgmp-dev \
    ffmpeg \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libmagickwand-dev \
    imagemagick \
    && rm -rf /var/lib/apt/lists/*

COPY xenforo/ /var/www/html/
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN usermod --uid 1000 www-data

# PHP extensions
RUN docker-php-ext-install mysqli pdo_mysql zip gmp

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j "$(nproc)" gd

# Imagick (stable PECL build works with PHP 8.2)
RUN pecl install imagick \
    && docker-php-ext-enable imagick

WORKDIR "/var/www/html"
