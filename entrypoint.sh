#!/bin/bash
cd /home/container

# Flag file octane installed
OCTANE_INSTALL_FLAG=".octane_installed_flag"

if [ -f composer.json ]; then
    echo "Verifying Composer dependencies..."
    composer install --no-dev --optimize-autoloader

    # Flag File Logic (hidden location)
    if [ ! -f "$OCTANE_INSTALL_FLAG" ]; then
        echo "Executing Octane installation..."
        php artisan octane:install --server=frankenphp

        # Create the flag file in the hidden location
        touch "$OCTANE_INSTALL_FLAG"
    fi

    php artisan optimize
fi

# Output Current PHP Version
php -version

MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
${MODIFIED_STARTUP}
