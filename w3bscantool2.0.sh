#!/bin/bash

# W3BSCANtool v2.8
# Escanea vulnerabilidades web
# Uso: ./w3bscantool2.8.sh -u <url> <1|2|3|4|5|6|7|8>
# Opciones de escaneo:
# 1) Escaneo rápido de puertos
# 2) Escaneo de puertos y servicios
# 3) Escaneo de vulnerabilidades con Nikto
# 4) Escaneo de vulnerabilidades LFI y RFI
# 5) Escaneo de archivos y directorios ocultos
# 6) Escaneo de vulnerabilidades de SQL Injection
# 7) Escaneo de vulnerabilidades de XSS
# 8) Escaneo silencioso con nmap
# 9) Instalar dependencias del sistema

cyan="\033[0;36m"
purple="\033[0;35m"
green="\033[0;32m"
yellow="\033[1;33m"
red="\033[0;31m"
nc="\033[0m"

echo -e "${red}╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮${nc}"
echo -e "${red}┃${cyan}                      #####                                                                 #####        ###   ${red}┃${nc}"
echo -e "${red}┃${cyan} #    # #     # #####   ####   ####    ##   #    # #####  ####   ####  #      #     #      #   #  ${red}┃${nc}"
echo -e "${red}┃${cyan} #    #       # #    # #      #    #  #  #  ##   #   #   #    # #    # #            #     #     # ${red}┃${nc}"
echo -e "${red}┃${cyan} #    #  #####  #####   ####  #      #    # # #  #   #   #    # #    # #       #####      #     # ${red}┃${nc}"
echo -e "${red}┃${cyan} # ## #       # #    #      # #      ###### #  # #   #   #    # #    # #      #       ### #     # ${red}┃${nc}"
echo -e "${red}┃${cyan} ##  ## #     # #    # #    # #    # #    # #   ##   #   #    # #    # #      #       ###  #   #  ${red}┃${nc}"
echo -e "${red}┃${cyan} #    #  #####  #####   ####   ####  #    # #    #   #    ####   ####  ###### ####### ###   ###   ${red}┃${nc}"
echo -e "${red}┃${purple}                      Escanea vulnerabilidades web             ${red}┃${nc}"
echo -e "${red}╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯${nc}"
echo ""
echo -e "${green}Uso:${nc} ./w3bscantool2.8.sh -u <url> <1|2|3|4|5|6|7|8>"
echo ""
echo -e "${purple}Opciones de escaneo:${nc}"


echo "1) Escaneo rápido de puertos"
echo "2) Escaneo de puertos y servicios"
echo "3) Escaneo de vulnerabilidades con Nikto"
echo "4) Escaneo de vulnerabilidades LFI y RFI"
echo "5) Escaneo de archivos y directorios ocultos"
echo "6) Escaneo de vulnerabilidades de SQL Injection"
echo "7) Escaneo de vulnerabilidades de XSS"
echo "8) Escaneo silencioso con nmap"
echo "9) Instalar dependencias del sistema "

# Función para instalar dependencias:
install_deps() {
    echo "Instalando dependencias..."
    # Detectar sistema operativo
    if [ -f /etc/debian_version ]; then
        # Debian, Ubuntu
        sudo apt-get update
        sudo apt-get install -y nmap nikto
    elif [ -f /etc/redhat-release ]; then
        # Red Hat, CentOS, Fedora
        if grep -q "CentOS Linux release 8" /etc/redhat-release; then
            sudo dnf update
            sudo dnf install -y nmap nikto
        else
            sudo yum update
            sudo yum install -y nmap nikto
        fi
    elif [ -f /etc/arch-release ]; then
        # Arch Linux
        sudo pacman -S nmap nikto
    elif grep -q "Kali" /etc/os-release; then
        # Kali Linux
        sudo apt-get update
        sudo apt-get install -y nmap nikto
    elif grep -q "Parrot" /etc/os-release; then
        # Parrot OS
        sudo apt-get update
        sudo apt-get install -y nmap nikto
    elif [ -f /etc/SuSE-release ] || [ -f /etc/SUSE-brand ] || [ -f /etc/SUSE-release ]; then
        # SUSE Linux
        sudo zypper refresh
        sudo zypper install -y nmap nikto
    elif [ -f /etc/alpine-release ]; then
        # Alpine Linux
        sudo apk update
        sudo apk add nmap nikto
    elif [ "$(uname)" == "Darwin" ]; then
        # macOS
        brew update
        brew install nmap nikto
    else
        echo "Error: No se pudo detectar el sistema operativo. Por favor, instale manualmente las siguientes dependencias: nmap, nikto."
        exit 1
    fi
    echo "Las dependencias se han instalado correctamente."
}
# Función para mostrar la ayuda:
show_help() {
    echo "Uso: $0 OPCIONES [ARGUMENTO]"
    echo ""
    echo "Opciones:"
    echo " 1) Escaneo rápido de puertos - Escanea los puertos abiertos en la máquina de forma rápida."
    echo " 2) Escaneo de puertos y servicios - Escanea los puertos abiertos y muestra los servicios asociados a cada uno."
    echo " 3) Escaneo de vulnerabilidades con Nikto - Escanea la máquina en busca de vulnerabilidades usando Nikto."
    echo " 4) Escaneo de vulnerabilidades LFI y RFI - Escanea la máquina en busca de vulnerabilidades de Local File Inclusion (LFI) y Remote File Inclusion (RFI)."
    echo " 5) Escaneo de archivos y directorios ocultos - Escanea la máquina en busca de archivos y directorios ocultos."
    echo " 6) Escaneo de vulnerabilidades de SQL Injection - Escanea la máquina en busca de vulnerabilidades de SQL Injection."
    echo " 7) Escaneo de vulnerabilidades de XSS - Escanea la máquina en busca de vulnerabilidades de Cross-site scripting (XSS)."
    echo " 8) Escaneo silencioso con nmap - Escanea los puertos abiertos en la máquina de forma silenciosa."
    echo "9) Instalar dependencias del sistema"

}

# Función para escanear rápidamente los puertos:
scan_ports() {
    echo "Escaneando puertos con nmap..."
    sudo nmap -T4 -F $url
}

# Función para escanear los puertos y servicios:
scan_services() {
    echo "Escaneando puertos y servicios con nmap..."
    sudo nmap -sV -T4 $url
}

# Función para escanear vulnerabilidades con Nikto:
scan_nikto() {
    echo "Escaneando vulnerabilidades con Nikto..."
    sudo nikto -h $url
}

# Función para escanear vulnerabilidades LFI y RFI:
scan_lfi_rfi() {
    echo "Escaneando vulnerabilidades LFI y RFI..."
    sudo nikto -h $url -Tuning 1234567 -C all
}

# Función para escanear archivos y directorios ocultos:
scan_hidden() {
    echo "Escaneando archivos y directorios ocultos con dirb..."
    sudo dirb $url -r
}

# Función para escanear vulnerabilidades de SQL Injection:
scan_sql_injection() {
    echo "Escaneando vulnerabilidades de SQL Injection con sqlmap..."
    sudo sqlmap -u $url --batch --level=5
}

# Función para escanear vulnerabilidades de XSS:
scan_xss() {
    echo "Escaneando vulnerabilidades de XSS con XSSer..."
    sudo xsser -u $url
}

# Verificar si se ha proporcionado una URL como argumento:
if [[ -z "$2" ]]; then
    echo "Error: Debe proporcionar una URL como argumento."
    echo ""
    show_help
    exit 1
fi
# Capturar los argumentos
url=""
option=""

while getopts "u:" opt; do
  case $opt in
    u) url="$OPTARG";;
    \?) echo "Opción inválida: -$OPTARG" >&2;;
  esac
done

shift $((OPTIND-1))
option="$1"

# Procesar la opción seleccionada
case $option in
  1) # Escaneo rápido de puertos
     nmap -T4 -F $url;;
  2) # Escaneo de puertos y servicios
     nmap -sV $url;;
  3) # Escaneo de vulnerabilidades con Nikto
     nikto -h $url;;
  4) # Escaneo de vulnerabilidades LFI y RFI
     nikto -h $url -Tuning 1234567;;
  5) # Escaneo de archivos y directorios ocultos
     nikto -h $url -C all;;
  6) # Escaneo de vulnerabilidades de SQL Injection
     nikto -h $url -Plugins "sql-injection";;
  7) # Escaneo de vulnerabilidades de XSS
     nikto -h $url -Plugins "xss";;
  8) # Escaneo silencioso con nmap
     nmap -T4 -sS -Pn $url;;
  9) # Instalar dependencias del sistema
     install_deps;;
  *) echo "Opción inválida: $option" >&2;;
esac
