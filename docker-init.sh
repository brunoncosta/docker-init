#!/bin/bash

echo "Cleaning Containers..."
sudo docker rm -f $(sudo docker ps -a -q)

projectDirectory=${PWD}
projectName=${PWD##*/}
projectHost="$projectName.local"

echo "-----"
echo "Project Directory: $projectDirectory"
echo "Project Name: $projectName"
echo "-----"

echo "nginx UUID:"
sudo docker run -d -p 80:80 -v $projectDirectory:/usr/share/nginx/html --hostname $projectName nginx

echo "mysql UUID:"
sudo docker run -d -v ~/docker-mysql:/var/lib/mysql --name mysql-$projectName -e MYSQL_ROOT_PASSWORD="password" mysql

echo "phpmyadmin UUID:"
sudo docker run --name phpmyadmin-$projectName -d --link mysql-$projectName:db -p 8080:80 phpmyadmin/phpmyadmin

sudo /bin/sh -c 'echo "127.0.0.1 '$projectHost' localhost" > /etc/hosts'

echo "-----"
echo "http://$projectHost"
echo "-----"
echo "phpmyadmin: http://$projectHost:8080"
echo "Username: root"
echo "Password: password"
echo "-----"
