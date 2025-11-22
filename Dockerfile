# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: PHP 8.4
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM dunglas/frankenphp:1.9-php8.4-bookworm

LABEL maintainer="Manuel Martinez <sina@serverscstrike.com>"

RUN apt-get update && apt-get install -y tini git zip unzip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && install-php-extensions pcntl pdo_mysql bcmath \
    && adduser --disabled-password --home /home/container container \
    && chown -R container:container /config/caddy /data/caddy /usr/local/bin/frankenphp

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/usr/bin/tini", "--", "/bin/bash", "/entrypoint.sh"]
