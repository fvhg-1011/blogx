FROM php:8.0
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
RUN php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN apt-get update -y
RUN apt-get install -y unzip 
WORKDIR /var/www/html
COPY . .

RUN cp .env.example .env

RUN composer install
RUN docker-php-ext-install pdo pdo_mysql
RUN php artisan key:generate
RUN php artisan migrate:fresh
CMD [ "php", "artisan", "serve", "--host=0.0.0.0"] 
