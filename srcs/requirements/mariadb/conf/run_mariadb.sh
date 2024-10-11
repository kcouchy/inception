#!/bin/sh

#TODO move these to .env
# DB_NAME = "testdb"
# DB_USER = "testuser"
# DB_PASS = "testpass"

# /usr/sbin/mysqld &
mariadbd-safe --nowatch

#check db status and continue when ok
mariadb-check -A
while [ $? != 0 ]
do
    mariadb-check -A
    sleep 1
done

#if not already created, create db and user
mariadb -e "CREATE DATABASE IF NOT EXISTS testdb;"
mariadb -e "CREATE USER IF NOT EXISTS testuser@'localhost' IDENTIFIED BY 'testpass';"
#give user all priveleges
mariadb -e "GRANT ALL PRIVILEGES ON testdb.* TO testuser@'%' IDENTIFIED BY 'testpass';"
#flush to update all user privileges
mariadb -e "FLUSH PRIVILEGES;"

#create a root password to protect the db, then shutdown
mariadb-admin -u root password "testpass"
mariadb-admin -u root -p"testpass" shutdown

mariadbd-safe