#!/bin/bash

# W3bscantool.sh
# Herramienta de escaneo de vulnerabilidades para sitios web
# Versión 2.0
Por favor ten en cuenta que el autor de esta herramienta no se hace responsable por el mal uso que se le pueda dar. La herramienta debe ser utilizada de manera ética y legal, y solo en sistemas y redes donde se tenga permiso explícito para hacerlo. El uso inapropiado de esta herramienta puede violar la privacidad y seguridad de otros usuarios, y puede ser ilegal en algunas jurisdicciones. Por favor, úsala con precaución y responsabilidad

Descripción
W3bscantool.sh es una herramienta de escaneo de vulnerabilidades diseñada para ayudar a proteger sitios web contra posibles ataques. Con esta herramienta, podrás detectar vulnerabilidades y riesgos de seguridad en tu sitio web. Ten en cuenta que el autor no se hace responsable por el mal uso que se le dé a esta herramienta y es tu responsabilidad usarla con precaución.

Instalación
Para instalar la herramienta, simplemente sigue estos pasos:

Abre una terminal y clona el repositorio de Github en tu computadora con el siguiente comando: git clone https://github.com/Rodrigo47363/w3bscantool2.0.sh/

Navega hasta el directorio w3bscantool2.0.sh con el comando: cd w3bscantool2.0.sh

Concede permisos de ejecución al archivo w3bscantool2.0.sh con el comando: chmod +x w3bscantool2.0.sh

Ahora puedes ejecutar el archivo w3bscantool2.0.sh con el siguiente comando, especificando la URL del sitio web que deseas escanear: ./w3bscantool2.0.sh -u [URL del sitio web]

Ten en cuenta que esta herramienta puede instalar automáticamente las dependencias necesarias para su uso, como Nmap y Nikto. Si esta herramienta te ayudó, siéntete libre de compartirla con cualquier persona que pueda necesitarla.

Uso

La herramienta W3bscantool.sh puede ser utilizada con las siguientes opciones:

-h: Muestra la ayuda y las opciones disponibles.
-u: Especifica la URL del sitio web a escanear.
-1: Realiza un escaneo rápido de puertos.
-2: Realiza un escaneo de puertos y servicios.
-3: Realiza un escaneo de vulnerabilidades con Nikto.
-4: Realiza un escaneo de vulnerabilidades LFI y RFI.
-5: Realiza un escaneo de archivos y directorios ocultos.
-6: Realiza un escaneo de vulnerabilidades de SQL Injection.
-7: Realiza un escaneo de vulnerabilidades de XSS.
-8: Realiza un escaneo silencioso con nmap.
-9: Instala dependencias del sistema.
Ejemplo de uso: ./w3bscantool2.0.sh -u [URL del sitio web] -1 -2 -3 -4 -5 -6 -7 -8

Contribución
Si deseas contribuir a este proyecto, puedes enviar una solicitud de extracción con tus cambios propuestos. Asegúrate de seguir las pautas de contribución del repositorio.

La herramienta de escaneo web es compatible con varios sistemas operativos, ya que tiene en cuenta diferentes distribuciones de Linux y macOS. Estos son los sistemas operativos compatibles que se enumeran en el script:

Debian
Ubuntu
Red Hat
CentOS
Fedora
Arch Linux
Kali Linux
Parrot OS
SUSE Linux
Alpine Linux
macOS

Si deseas contribuir a este proyecto, puedes enviar una solicitud de extracción con tus cambios propuestos y asegurarte de seguir las pautas de contribución del repositorio. Si esta herramienta te ha resultado útil, no dudes en compartirla con otros que puedan necesitarla.
