# Utilise PHP 8.0 avec PHP-FPM
FROM php:8.0-fpm

# Installe Composer (copie depuis l'image officielle Composer)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Installe les extensions PHP nécessaires (ajoute-en d'autres si besoin)
RUN docker-php-ext-install mysqli

# Définir le répertoire de travail par défaut
WORKDIR /var/www/html

# Copier les fichiers de l'application dans le conteneur
COPY . /var/www/html/

# Installer les dépendances via Composer dans le bon répertoire
RUN composer install --ignore-platform-reqs --working-dir=/var/www/html

# Assurez-vous que les permissions sont correctes
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

# Expose le port 9000 (utilisé par PHP-FPM)
EXPOSE 8080

# Commande par défaut pour PHP-FPM
CMD ["php-fpm"]