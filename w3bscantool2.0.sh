#!/bin/bash

# Función para mostrar el banner
show_banner() {
  echo "--------------------------------------"
  echo "|        w3bscantool.sh              |"
  echo "|    Herramienta de Escaneo Web      |"
  echo "|   Hecho por Root/user/47363        |"
  echo "--------------------------------------"
  echo ""
}

# Función para instalar dependencias
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
    sudo pacman -Sy nmap nikto
  else
    echo "Error: No se pudo detectar el sistema operativo. Por favor, instale manualmente las siguientes dependencias: nmap, nikto."
    exit 1
  fi
}

# Función principal
main() {
  # Mostrar banner
  show_banner
  
  # Verificar si las dependencias están instaladas
  if ! command -v nmap >/dev/null 2>&1 || ! command -v nikto >/dev/null 2>&1; then
    echo "Algunas de las dependencias necesarias no están instaladas."
    read -p "¿Desea instalarlas ahora? (s/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Ss]$ ]]; then
      install_deps
    else
      echo "Error: Las dependencias necesarias no están instaladas."
      exit 1
    fi
  fi

  # Obtener la URL del sitio web objetivo desde el argumento -u
  while getopts u: option
  do
    case "${option}"
    in
    u) url=${OPTARG};;
    esac
  done

  # Verificar si se proporcionó una URL
  if [ -z "$url" ]
  then
    echo "Error: no se proporcionó una URL."
    exit 1
  fi

  # Obtener la dirección IP del sitio web
  ip=$(nslookup $url | awk '/^Address: / { print $2 }')

  # Verificar si el sitio web está disponible
  if ! curl --output /dev/null --silent --head --fail "$url"; then
    echo "Error: el sitio web no está disponible."
    exit 1
  fi

  # Obtener los puertos abiertos del sitio web y los servicios vulnerables
  echo "Seleccione una opción:"
  echo "1) Escaneo rápido de puertos"
  echo "2) Escaneo de puertos y servicios"
  echo "3) Escaneo de vulnerabilidades con Nikto"
  read -p "> " scan_option

  case $scan_option in
    1)
      # Escaneo rápido de puertos
      echo "Escaneando los puertos abiertos en $url..."
      nmap -F $ip
      ;;
    2)
      #

Escaneo de puertos y servicios
echo "Escaneando los puertos abiertos y servicios en $url..."
nmap -A $ip
;;
3)
# Escaneo de vulnerabilidades con Nikto
echo "Escaneando vulnerabilidades con Nikto en $url..."
nikto -h $url
;;
*)
echo "Opción no válida."
exit 1
;;
esac
}

Ejecutar la función principal
main "$@"