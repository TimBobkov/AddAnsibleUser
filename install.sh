#!/usr/bin/env bash

apt-get update && apt-get install -y python-pip

#add and cofig user
useradd -m -s /bin/bash ansible #создали пользователя
#password=$(head -c 100 /dev/urandom | base64 | sed 's/[+=/A-Z]//g' | tail -c 11) #сгенерировали пароль
#echo -e "$password\n$password\n" | passwd ansible #изменили пароль
mkdir -p /home/ansible/.ssh #создали папку под ключи
ssh-keygen -i -f ./keys/key.pub >> /home/ansible/.ssh/authorized_keys #добавили ключ для входа
chown -R ansible:ansible /home/ansible/.ssh/ #изменили владельца папки на пользователя ansible
chmod 700 -R /home/ansible/.ssh/ #дали правильные права
groupadd docker >> /dev/null #добавили группу для docker, если ее нет
usermod -a -G docker ansible #добавили пользователя в группу
echo "ansible ALL=(ALL:ALL) NOPASSWD: ALL" | EDITOR='tee -a' visudo >> /dev/null
