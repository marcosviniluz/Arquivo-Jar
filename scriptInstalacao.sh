#!/bin/bash#!/bin/bash

# Garantir permissões corretas
chmod 755 $0
chmod 644 script.sql

echo "$(tput setaf 10)[Air Totem assistente]:$(tput setaf 7) Olá, serei seu assistente para instalação da nossa aplicação!;"
echo "$(tput setaf 10)[Air Totem assistente]:$(tput setaf 7) Verificando aqui se você possui o Java instalado...;"
sleep 2

java -version
if [ $? -eq 0 ]; then
    echo "$(tput setaf 10)[Air Totem assistente]:$(tput setaf 7) Você já tem o Java instalado!!!"
else
    echo "$(tput setaf 10)[Air Totem assistente]:$(tput setaf 7) Opa! Não identifiquei nenhuma versão do Java instalada, mas sem problemas, irei resolver isso agora!"
    echo "$(tput setaf 10)[Air Totem assistente]:$(tput setaf 7) Instalando Java na sua máquina"
    sleep 2
    sudo apt update
    sudo apt install openjdk-17-jre -y
    echo "$(tput setaf 10)[Air Totem assistente]:$(tput setaf 7) Java instalado com sucesso!"
fi

echo "$(tput setaf 10)[Air Totem assistente]:$(tput setaf 7) Agora vamos configurar sua máquina para receber nossa aplicação;"
sudo apt update && sudo apt upgrade -y
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker

echo "$(tput setaf 10)[Air Totem assistente]:$(tput setaf 7) Configurando o banco de dados MySQL;"
sudo docker pull mysql:5.7
sudo docker run -d -p 3306:3306 --name ContainerBD -e "MYSQL_ROOT_PASSWORD=urubu100" mysql:5.7

echo "$(tput setaf 10)[Air Totem assistente]:$(tput setaf 7) Esperando o banco de dados inicializar..."
sleep 20

# Use o caminho absoluto para o arquivo script.sql
SCRIPT_PATH=$(pwd)/script.sql

echo "$(tput setaf 10)[Air Totem assistente]:$(tput setaf 7) Copiando script.sql para o container..."
sudo docker cp $SCRIPT_PATH ContainerBD:/tmp/script.sql

echo "$(tput setaf 10)[Air Totem assistente]:$(tput setaf 7) Executando script.sql no banco de dados..."
sudo docker exec -i ContainerBD mysql -u root -purubu100 -e "source /tmp/script.sql"

echo "$(tput setaf 10)[Air Totem assistente]:$(tput setaf 7) Banco de dados configurado, agora inicialize a nossa aplicação"
ql
sudo docker exec -i ContainerBD mysql -u root -purubu100 < /script.sql

echo "$(tput setaf 10)[Air Totem assistente]:$(tput setaf 7) Banco de dados configurado, agora inicialize a nossa aplicação"
