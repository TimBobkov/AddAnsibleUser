#!/usr/bin/env bash
echo "THIS SCRIPT IS ONLY FOR TESTING TASKS!!!"
echo "---Press any key for continue---"
read
echo -n "Enter prog folder (example: /path/to/prog): "
read folder
[ -d $folder ] && cd / || (echo "Folder does not exist"; exit 1)

docker stop $(docker ps -q)
docker container rm $(docker ps -q -a)

docker network rm $(docker network ls -q)
docker volume rm $(docker volume ls -q)

userdel -f ansible
[ -d "/home/ansible" ] && rm -r "/home/ansible"
rm -r $folder