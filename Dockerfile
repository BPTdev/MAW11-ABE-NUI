# Utilise l'image officielle PHP 8.0 avec Apache
FROM php:8.0-apache

# Installe Composer en utilisant la dernière version disponible
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Installe des extensions PHP nécessaires (ajoutez d'autres si besoin)
RUN docker-php-ext-install mysqli

# Définir le répertoire de travail par défaut
WORKDIR /var/www/html

# Copier les fichiers de l'application dans le conteneur
COPY . /var/www/html/

# Mettre à jour la configuration d'Apache pour définir le DocumentRoot sur /var/www/html/public
RUN sed -ri -e 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/*.conf

# Activer le module de réécriture d'URL si nécessaire
RUN a2enmod rewrite

# Installer les dépendances via Composer dans le bon répertoire
RUN composer install --ignore-platform-reqs --working-dir=/var/www/html

# Assurez-vous que le conteneur utilise les permissions correctes (si nécessaire)
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

# Exposez le port 80 pour le serveur Apache
EXPOSE 80

# Commande par défaut pour démarrer Apache
CMD ["apache2-foreground"]