#!/bin/bash

Funcion para mostrar el banner y la ayuda:
show_banner() {
echo "######################################################"
echo "# Herramienta de escaneo web v 2.0 #"
echo "# #"
echo "# Escanea vulnerabilidades LFI y RFI #"
echo "# #"
echo "# Ejemplo de uso: ./w3bscantool2.0.sh -u <url> [-h] [-l] [-r] [-s] [-q] [-x] #"
echo "# #"
echo "# Opciones: #"
echo "# -h Mostrar este mensaje de ayuda #"
echo "# -u Especificar la URL del sitio web a escanear #"
echo "# -l Escanear vulnerabilidades LFI #"
echo "# -r Escanear vulnerabilidades RFI #"
echo "# -s Escanear vulnerabilidades de SQL injection #"
echo "# -q Escanear vulnerabilidades de CMS específicas #"
echo "# -x Escanear vulnerabilidades de XSS #"
echo "######################################################"
}


# Funcion para instalar dependencias:
install_deps() {
    echo "Instalando dependencias..."

    # Detectar sistema operativo
    if [ -f /etc/debian_version ]; then
        # Debian, Ubuntu
        sudo apt-get update
        sudo apt-get install -y nmap nikto
    elif [ -f /etc/redhat-release ]; then
        # Red Hat, CentOS, Fedora
        sudo yum update
        sudo yum install -y nmap nikto
    elif [ -f /etc/arch-release ]; then
        # Arch Linux
        sudo pacman -Syu nmap nikto
    else
        echo "Error: No se pudo detectar el sistema operativo. Por favor, instale manualmente las siguientes dependencias: nmap, nikto."
        exit 1
    fi
}

# Funcion para escanear vulnerabilidades LFI
scan_lfi() {
    echo "Escaneando vulnerabilidades LFI en $url ..."
    # Comandos para escanear LFI
    # ...
}

# Funcion para escanear vulnerabilidades RFI
scan_rfi() {
    echo "Escaneando vulnerabilidades RFI en $url ..."
    # Comandos para escanear RFI
    # ...
}

# Funcion para escanear vulnerabilidades de SQL injection
scan_sql_injection() {
    echo "Escaneando vulnerabilidades de SQL injection en $url ..."
    # Comandos para escanear SQL injection
    sqlmap -u $url --dbs
}

# Funcion para escanear vulnerabilidades de XSS
scan_xss() {
    echo "Escaneando vulnerabilidades de XSS en $url ..."
    # Comandos para escanear XSS
    xsser -u $url
}

# Funcion para escanear subdominios
scan_subdomains() {
    echo "Escaneando subdominios en $url ..."
    # Comandos para escanear subdominios
    sublist3r -d $url
}

# Funcion para escanear archivos y directorios ocultos
scan_hidden_files() {
    echo "Escaneando archivos y directorios ocultos en $url ..."
    # Comandos para escanear archivos y directorios ocultos
    gobuster dir -u $url -w /usr/share/wordlists/dirb/common.txt
}

# Funcion para escanear vulnerabilidades de CMS especificas
scan_cms_vulnerabilities() {
    read -p "Ingrese el nombre del CMS que desea escanear: " cms_name
echo "Escaneando vulnerabilidades de $cms_name en $url ..."
# Comandos para escanear vulnerabilidades de CMS especificas
# ...
}

Funcion principal del programa
main() {
show_banner
install_deps
# Analizar argumentos de linea de comandos
while getopts "u:hlsrqx" option; do
    case "${option}" in
        u)
            url=${OPTARG}
            ;;
        h)
            show_banner
            ;;
        l)
            scan_lfi
            ;;
        r)
            scan_rfi
            ;;
        s)
            scan_sql_injection
            ;;
        q)
            scan_cms_vulnerabilities
            ;;
        x)
            scan_xss
            ;;
        *)
            echo "Opcion invalida. Ejecute el script con la opcion -h para obtener ayuda."
            exit 1
            ;;
    esac
done
}

Llamar a la funcion principal del programa
main "$@"
