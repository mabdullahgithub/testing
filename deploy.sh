#!/bin/bash
set -e

echo "Deploying application..."

# Enter maintenance mode
(php artisan down) || true

# Update codebase
git pull origin master

# Install dependencies
composer install --no-interaction --prefer-dist --optimize-autoloader

# Clear cache
php artisan optimize:clear

# Migrate database
php artisan migrate --force

# Clear and cache config
php artisan config:cache

# Clear and cache routes
php artisan route:cache

# Clear and cache views
php artisan view:cache

# Install node modules
npm install

# Build assets
npm run build

# Exit maintenance mode
php artisan up

echo "Application deployed!"