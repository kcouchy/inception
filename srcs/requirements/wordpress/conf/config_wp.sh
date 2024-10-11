#!/bin/sh

# if config files does not exist, make one!
if [ ! -e "${WP_DIR}/wp-config.php" ]
then

    # Creates a new wp-config.php with database constants, and verifies that the database constants are correct. 
    wp config create    --allow-root            \
                        --db_name=$MDB_NAME     \
                        --db_user=$MDB_USER     \
                        --db_pass=$MDB_PASS     \
                        --db_host=mariadb:3306  \
                        --path=$WP_DIR

    # Runs the standard WordPress installation process. Creates the WordPress tables in the database using the URL, title, and default admin user details provided.
    wp core install     --allow-root                    \
                        --url=$WP_URL                   \
                        --title=$WP_TITLE               \
                        --admin_user=$WP_ADMIN          \
                        --admin_password=$WP_ADMIN_PASS \
                        --admin_email= $WP_ADMIN_EMAIL  \
                        --skip-email                    \
                        --path=$WP_DIR

    wp user create      $WP_USER $WP_USER_EMAIL     \
                        --allow-root                \
                        --role=subscriber           \
                        --user_pass=$WP_USER_PASS

    wp option update home 'https://kcouchma.42.fr' --allow-root
	wp option update siteurl 'https://kcouchma.42.fr' --allow-root

else
    echo "wordpress config already completed"
fi

# Start the PHP FastCGI Process Manager in the foreground to keep container open
/usr/sbin/php-fpm7.4 -F