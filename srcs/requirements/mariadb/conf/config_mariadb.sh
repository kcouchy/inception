#!/bin/sh

#launch db in background in order to configure the db
mariadbd-safe --nowatch

#check db status and continue when ok
while ! mariadb-check -A
do
    sleep 1
done

#if not already created, create db and user
mariadb -e "CREATE DATABASE IF NOT EXISTS $MDB_NAME;"
mariadb -e "CREATE USER IF NOT EXISTS $MDB_USER@'localhost' IDENTIFIED BY '$MDB_PASS';"
#give user all priveleges
mariadb -e "GRANT ALL PRIVILEGES ON $MDB_NAME.* TO $MDB_USER@'%' IDENTIFIED BY '$MDB_PASS';"
#flush to update all user privileges
mariadb -e "FLUSH PRIVILEGES;"

#create a root password to protect the db, then shutdown
mariadb-admin -u root password "$MDB_PASS"
mariadb-admin -u root -p"$MDB_PASS" shutdown

#file as setup success flag
touch /setup

#launch db in foreground to keep container open
mariadbd-safe