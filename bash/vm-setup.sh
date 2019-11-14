#!/bin/bash

printf "\n%s\n" "Grant Root Access"

# sudo -i

printf "\n%s\n" "Installing packages"
apt-get update
apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
apt update
apt-cache policy docker-ce
apt remove docker docker-engine docker.io
apt install docker-ce
systemctl status docker
systemctl enable docker

docker --version

printf "\n%s\n" "Installing Node 12.x"

curl -sL https://deb.nodesource.com/setup_12.x | bash -
apt-get install -y nodejs

printf "\n%s\n" "Installing Yarn"
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" |  tee /etc/apt/sources.list.d/yarn.list
apt-get update && apt-get install yarn

printf "\n%s\n" "Move to Demo Root Directory"
cd ..

printf "\n%s\n" "Installing Node Dependencies"
yarn install
printf "\n%s\n" "Start application application"
node index