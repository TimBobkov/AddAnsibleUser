#!/usr/bin/env bash

#install prerequisites
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y apt-transport-https ca-certificates docker-ce python-pip
curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
pip install docker
pip install docker-compose==1.15.0

#add and cofig user
useradd -m -s /bin/bash ansible #создали пользователя
#password=$(head -c 100 /dev/urandom | base64 | sed 's/[+=/A-Z]//g' | tail -c 11) #сгенерировали пароль
#echo -e "$password\n$password\n" | passwd ansible #изменили пароль
mkdir -p /home/ansible/.ssh #создали папку под ключи
ssh-keygen -i -f ./keys/key.pub >> /home/ansible/.ssh/authorized_keys #добавили ключ для входа
chown -R ansible:ansible /home/ansible/.ssh/ #изменили владельца папки на пользователя ansible
chmod 700 -R /home/ansible/.ssh/ #дали правильные права
groupadd docker #добавили группу для docker, если ее нет
usermod -a -G docker ansible #добавили пользователя в группу
service docker restart #перезапустили docker
echo "ansible ALL=(ALL:ALL) NOPASSWD: ALL" | EDITOR='tee -a' visudo
