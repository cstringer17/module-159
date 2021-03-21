#!/bin/bash -e

#sudo pacman -Rcns docker
#sudo pacman -S docker
#sudo systemctl start docker

sudo docker stop ldap-service
sudo docker rm ldap-service

sudo docker stop phpldapadmin-service
sudo docker rm phpldapadmin-service

sudo docker stop owncloud
sudo docker rm owncloud

sudo docker run \
    --name ldap-service \
    --hostname ldap-service \
	--env LDAP_ORGANISATION="gerzenstein" \
	--env LDAP_DOMAIN="gerzenstein.com" \
	--env LDAP_ADMIN_PASSWORD="admin" \
	--detach osixia/openldap:1.1.8

sudo docker run --name phpldapadmin-service -p 9090:80 --hostname phpldapadmin-service --link ldap-service:ldap-host --env PHPLDAPADMIN_HTTPS=false --env PHPLDAPADMIN_LDAP_HOSTS=ldap-host --detach osixia/phpldapadmin:0.9.0

sudo docker run --name owncloud -d -p 8080:80  owncloud:8.1 


echo "Login DN: cn=admin,dc=gerzenstein,dc=com"
echo "Password: admin"
