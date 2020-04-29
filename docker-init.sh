#!/bin/bash

projectDirectory=${PWD}
projectName=${PWD##*/}
projectHost="$projectName.local"

echo "-----"
echo "Project Directory: $projectDirectory"
echo "Project Name: $projectName"
echo "-----"

echo "php 7.4.5-apache UUID:"
sudo docker run -d -p 80:80 -v $projectDirectory:/var/www/html --name php-$projectName php:7.4.5-apache

# echo "nginx lasted UUID:"
# sudo docker run -d -p 80:80 -v $projectDirectory:/usr/share/nginx/html --hostname $projectName nginx

echo "mysql lasted UUID:"
sudo docker run -d -v ~/docker-mysql:/var/lib/mysql --name mysql-$projectName -e MYSQL_ROOT_PASSWORD="password" mysql

echo "phpmyadmin lasted UUID:"
sudo docker run -d -p 8080:80 --name phpmyadmin-$projectName --link mysql-$projectName:db phpmyadmin/phpmyadmin

sudo /bin/sh -c 'echo "127.0.0.1 '$projectHost' localhost" > /etc/hosts'

echo "-----"
echo "http://$projectHost"
echo "-----"
echo "phpmyadmin: http://$projectHost:8080"
echo "Username: root"
echo "Password: password"
echo "-----"
