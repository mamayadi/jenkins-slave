#!/bin/bash
echo "Creating docker container for Jenkins slave and a dind container for build images"
docker-compose -f docker-compose.yml -p slave up -d --build --force-recreate --remove-orphans 