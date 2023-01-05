#!/bin/bash

#Almaceno la version mas reciente
GoV="$(wget -qO- https://golang.org/dl/ | grep -oP 'go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1)"
sudo apt update &> /dev/null 2>&1
echo "Se está Instalando/actualizando"

#Elimino la version actual
ls /usr/local/bin/go &> /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Actualmente cuenta con una version de golang instalada, se eliminará..."
    sudo rm -rf /usr/local/bin/go
fi

wget -q https://dl.google.com/go/${GoV} &> /dev/null 2>&1

sudo tar -C /usr/local/bin/ -xzf ~/"${GoV}" &> /dev/null 2>&1

rm -fr ${GoV}

unset $GoV

export PATH=$PATH:/usr/local/bin/go

sudo mkdir -p ~/go/{bin,pkg,src}
echo "export GOPATH=~/go" >> ~/.profile && source ~/.profile

sudo unlink /usr/bin/go
sudo unlink /lib/go

sudo ln -s /usr/local/bin/go/bin/go /usr/bin
sudo ln -s /usr/local/bin/go /lib/go

echo "export PATH='$PATH':/usr/local/bin/go/bin/:$GOPATH/bin" >> ~/.profile && source ~/.profile
go get -u github.com/golang/dep/cmd/dep &> /dev/null 2>&1

echo "Instalado con exito"
