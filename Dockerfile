######
# BASE STAGE PHP
######
FROM php:8.3.4-fpm as php-base

# Install git
RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/* && \
    git config --system user.name "Jules" && \
    git config --system user.email "jules@dev.fr"

# Install needed packages
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions zip sockets pdo_mysql intl gd && \
    rm -f /usr/local/bin/install-php-extensions

# Set PHP limits
RUN echo "memory_limit=512M" > /usr/local/etc/php/conf.d/memory_limit.ini
RUN echo "post_max_size=64M" > /usr/local/etc/php/conf.d/post_max_size.ini
RUN echo "upload_max_filesize=64M" > /usr/local/etc/php/conf.d/upload_max_filesize.ini
RUN echo "session.gc_maxlifetime=2592000" > /usr/local/etc/php/conf.d/session.ini
RUN echo "session.cookie_lifetime=2592000" >> /usr/local/etc/php/conf.d/session.ini

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# DEV STAGE PHP
FROM php-base as php-dev
# Install Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash && \
    mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

#user and group that will be used
ARG USER_ID=1000
ARG GROUP_ID=1000

## --- set the right user and group inside the container ---
COPY user_entry_point.sh /user_entry_point.sh
RUN chmod +x /user_entry_point.sh
RUN /user_entry_point.sh ${USER_ID} ${GROUP_ID}

#switch to the good user
USER ${USER_ID}:${GROUP_ID}

# DEV STAGE PROD
FROM php-base as php-prod


######
# DEV STAGE NODE
######
FROM node:22 AS node-dev


#user and group that will be used
ARG USER_ID=1000
ARG GROUP_ID=1000

## --- set the right user and group inside the container ---
COPY --chmod=0755 user_entry_point.sh /user_entry_point.sh
RUN /user_entry_point.sh ${USER_ID} ${GROUP_ID}

#switch to the good user
USER ${USER_ID}:${GROUP_ID}