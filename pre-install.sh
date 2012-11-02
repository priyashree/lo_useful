#!/bin/bash




final()
{
    echo " "; echo " "; echo " ";
    echo "Principais dependencias instaladas!"
}

clone()
{
    echo " "
    read -p "Deseja clonar o repositorio agora? (S) ou (N): " resp
    if [ "$resp" == "n" ] || [ "$resp" == "N" ]; then
        exit
    elif [ "$resp" == "s" ] || [ "$resp" == "S" ]; then
        echo " "
        echo "Digite a pasta de destino (caso nao exista, sera criada) com caminho absoluto"
        read -p "Ou pressione <enter> para usar a pasta padrao ($HOME):" pasta

        if [ "$pasta" == "" ]; then
            cd $HOME
            echo "Clonando o repositorio 'core' para a pasta $HOME/libo"
        else
            if [ -d "$pasta" ]; then
                mkdir -p "$pasta"
            fi
        fi
        
        cd $pasta
        echo "Clonando o repositorio 'core' para a pasta $pasta"

        git clone git://anongit.freedesktop.org/libreoffice/core libo && echo "Clonagem concluida! Tudo pronto."
    fi
}

##
## Script begin
##
clear
echo " Instalacao dos pre-requisitos para compilar o LO"
echo " "
echo "1. Debian/Ubuntu"
echo "2. Fedora"; echo " "
read -p "Escolha sua distro: " distro

if [ "$distro" == "1" ]; then
    echo "Instalacao dos pre-requisitos em ambiente Debian/Ubuntu"
    echo " "
    sudo apt-get update
    sudo apt-get build-dep libreoffice
    sudo apt-get install git-core libgnomeui-dev gawk junit4 doxygen
    final
    clone
elif [ "$distro" == "2" ]; then
    echo "Instalacao dos pre-requisitos em ambiente Fedora"
    echo " "
    sudo yum update
    sudo yum-builddep libreoffice
    sudo yum install git libgnomeui-devel gawk junit doxygen
    final
    clone
else
    echo "Desculpe, opcao invalida!"
fi