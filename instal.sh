#!/usr/bin/env bash

useradd -m -s /bin/bash ansible #создали пользователя
password=$(head -c 100 /dev/urandom | base64 | sed 's/[+=/A-Z]//g' | tail -c 11) #сгенерировали пароль
echo -e "$password\n$password\n" | passwd ansible #изменили пароль
mkdir -p /home/ansible/.ssh #создали папку под ключи
ssh-keygen -i -f ./keys/id_rsa.pub >> /home/ansible/.ssh/authorized_keys #добавили ключ для входа
chown -R ansible:ansible /home/ansible/.ssh/ #изменили владельца папки на пользователя ansible
chmod 700 -R /home/ansible/.ssh/ #дали правильные права
groupadd docker #добавили группу для docker, если ее нет
usermod -a -G docker ansible #добавили пользователя в группу
service docker restart #перезапустили docker
echo "ansible ALL=(ALL:ALL) NOPASSWD: /usr/bin/curl -L https\://github.com/docker/compose/releases/download/*/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose" | EDITOR='tee -a' visudo #даем право пользователю ansible на обновление docker-compose
echo "ansible ALL=(ALL:ALL) NOPASSWD: /usr/bin/apt-get install -y --only-upgrade docker-ce" | EDITOR='tee -a' visudo #даем право пользователю ansible на обновление docker
echo "ansible ALL=(ALL:ALL) NOPASSWD: /usr/bin/apt-get update" | EDITOR='tee -a' visudo #даем право пользователю ansible на обновление локального кеша репозиториев