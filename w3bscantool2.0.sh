#!/bin/bash
######################################################

# Herramienta de escaneo web v 2.0
# Escanea vulnerabilidades web
# Ejemplo de uso:
# Escanear una URL en busca de vulnerabilidades:
# ./w3bscantool2.0.sh -u <url> <1|2|3|4|5|6|7|8>
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
######################################################

# Función para instalar dependencias:
install_deps() {
    # Comentario descriptivo de la función
    echo "Instalando dependencias..."

    # Detectar sistema operativo
if [ -f /etc/debian_version ]; then
    # Debian, Ubuntu
    sudo apt-get update
    sudo apt-get install -y nmap nikto
elif [ -f /etc/redhat-release ]; then
    # Red Hat, CentOS, Fedora
    if [ grep -q "CentOS Linux release 8" /etc/redhat-release ]; then
        sudo dnf update
        sudo dnf install -y nmap nikto
    else
        sudo yum update
        sudo yum install -y nmap nikto
    fi
elif [ -f /etc/arch-release ]; then
    # Arch Linux
    sudo pacman -S nmap nikto
elif [ -f /etc/os-release ] && grep -q "Kali" /etc/os-release; then
    # Kali Linux
    sudo apt-get update
    sudo apt-get install -y nmap nikto
elif [ -f /etc/os-release ] && grep -q "Parrot" /etc/os-release; then
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
}

# Función para escanear vulnerabilidades de LFI
scan_lfi() {
    echo "Realizando escaneo de vulnerabilidades de LFI en $url..."
    nmap -sS -sV -p- -T5 -A -O -oN output.txt $url
}

# Función para escanear vulnerabilidades de RFI
scan_rfi() {
    echo "Realizando escaneo de vulnerabilidades de RFI en $url..."
    curl -v "$url/?url=http://google.com"
}

# Función para escanear archivos y directorios ocultos
scan_hidden_files() {
    echo "Realizando escaneo de archivos y directorios ocultos en $url..."
    dirsearch -u "$url" -e php,asp,jsp,aspx,txt,html,js,css,png,jpg,gif,svg,woff,woff2,eot,ttf,xml,zip,tar.gz
}

# Función para escanear vulnerabilidades de XSS
scan_xss() {
    echo "Realizando escaneo de vulnerabilidades de XSS en $url..."
    python3 xsser.py -u "$url" --auto --skip --threads 10 --level 3
}

#Función principal del programa
main() {

# Verificar si se proporcionó una URL
if [ -z "$url" ]; then
    echo "Error: debe proporcionar una URL para escanear"
    exit 1
fi

# Instalar dependencias si se selecciona la opción correspondiente
if [ "$option" == "9" ]; then
install_deps
exit 0
fi

Realizar la acción seleccionada por el usuario
case "$option" in
"1") scan_ports_quick ;;
"2") scan_ports_services ;;
"3") scan_nikto ;;
"4") scan_lfi && scan_rfi ;;
"5") scan_hidden_files ;;
"6") scan_sql_injection ;;
"7") scan_xss ;;
"8") scan_ports_silent ;;
*) echo "Error: opción inválida" ;;
esac

exit 0
}

# Parsear argumentos de línea de comandos
while getopts ":u:" opt; do
case $opt in
u) url="$OPTARG" ;;
?) echo "Opción inválida -$OPTARG" >&2 ;;
:) echo "La opción -$OPTARG requiere un argumento" >&2 ;;
esac
done

# Leer la opción del usuario después de los argumentos de línea de comandos
read -p "Seleccione una opción (1-8): " option

# Llamar a la función principal
main

# Mensaje de finalización
echo "Programa finalizado."
