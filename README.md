#W3bscantool.sh
W3bscantool.sh es una herramienta de escaneo de vulnerabilidades diseñada para ayudar a proteger sitios web contra posibles ataques. Con esta herramienta, podrás detectar vulnerabilidades y riesgos de seguridad en tu sitio web. Ten en cuenta que el autor no se hace responsable por el mal uso que se le dé a esta herramienta y es tu responsabilidad usarla con precaución.

Instalación
Para instalar la herramienta, simplemente sigue estos pasos:

Abre una terminal y clona el repositorio de Github en tu computadora con el siguiente comando: git clone https://github.com/Rodrigo47363/w3bscantool2.0.sh/

Navega hasta el directorio w3bscantool2.0.sh con el comando: cd w3bscantool2.0.sh

Concede permisos de ejecución al archivo w3bscantool2.0.sh con el comando: chmod +x w3bscantool2.0.sh

Ahora puedes ejecutar el archivo w3bscantool2.0.sh con el siguiente comando, especificando la URL del sitio web que deseas escanear: ./w3bscantool2.0.sh -u [URL del sitio web]

Ten en cuenta que esta herramienta puede instalar automáticamente las dependencias necesarias para su uso, como Nmap, y nikto, y que si esta herramienta te ayudó, siéntete libre de compartirla con cualquier persona que pueda necesitarla.

Uso
La herramienta W3bscantool.sh puede ser utilizada con las siguientes opciones:

-h: Muestra la ayuda y las opciones disponibles.

-u: Especifica la URL del sitio web a escanear.

-i: Realiza un escaneo de información del sitio web.

-l: Escanea vulnerabilidades LFI.

-r: Escanea vulnerabilidades RFI.

-s: Escanea vulnerabilidades de SQL injection.

-q: Escanea vulnerabilidades de CMS específicas.

-x: Escanea vulnerabilidades de XSS.

Ejemplo de uso: ./w3bscantool2.0.sh -u [URL del sitio web] -i -l -r -s -q -x

Contribución
Si deseas contribuir a este proyecto, puedes enviar una solicitud de extracción con tus cambios propuestos. Asegúrate de seguir las pautas de contribución del repositorio.
