Debian 12 GNOME Post-Installation Script
Este script de Bash automatiza tareas post-instalación para Debian 12 con el entorno de escritorio GNOME, incluyendo actualizaciones del sistema, instalación de software, configuración de extensiones de GNOME, y más. Ofrece un menú interactivo para ejecutar tareas individualmente (instalación o desinstalación) o todas a la vez.
Características

Menú interactivo: Permite seleccionar tareas específicas para instalación o desinstalación.
Validaciones: Verifica si los paquetes ya están instalados antes de proceder.
Soporte multilingüe: Instrucciones en español con mensajes claros.
Tareas incluidas:
Actualización del sistema y limpieza de paquetes.
Habilitación de repositorios contrib y non-free.
Instalación de navegadores (Firefox ESR, Chromium, Google Chrome, Mullvad, y más).
Configuración de extensiones de GNOME (Dash to Dock, GNOME Shell Extensions).
Instalación de herramientas como VLC, LibreOffice, GIMP, Flatpak, y fuentes Microsoft.
Configuración de seguridad (UFW, SSH, OpenVPN).
Actualización de .bashrc para personalizar la terminal.


Desinstalación: Permite revertir cambios (donde aplicable) como la eliminación de paquetes o restauración de configuraciones.
Mensajes de progreso: Muestra el estado de cada tarea con colores para facilitar el seguimiento.

Requisitos

Debian 12 con GNOME instalado.
Privilegios de sudo.
Conexión a internet.
Terminal Bash.

Uso

Descarga el script:wget https://github.com/jadm2907/debian12-postinstall.git 


Hazlo ejecutable:chmod +x debian12_postinstalacion.sh


Ejecútalo con sudo:sudo ./debian12_postinstalacion.sh


Sigue el menú interactivo:
Selecciona un número del 1 al 26 para tareas individuales (instalación).
Selecciona 27 para ejecutar todas las tareas de instalación.
Selecciona 28 para desinstalar una tarea específica.
Selecciona 29 para salir.



Tareas Incluidas

Actualizar el sistema (apt update && apt full-upgrade).
Habilitar repositorios contrib y non-free.
Instalar actualizaciones de firmware.
Instalar GNOME Tweaks.
Instalar extensiones de GNOME Shell.
Instalar Dash to Dock.
Habilitar Luz Nocturna (manual).
Instalar códecs multimedia.
Instalar 10 navegadores web (Firefox ESR, Chromium, Google Chrome, Mullvad, etc.).
Configurar cortafuegos (UFW).
Instalar Synaptic Package Manager.
Inst imperatives de respaldo (Déjà Dup).
Optimizar ajustes de energía (manual).
Instalar controladores propietarios (manual).
Configurar sincronización de archivos (manual).
Instalar software de productividad (LibreOffice, GIMP).
Configurar SSH.
Configurar VPN (OpenVPN).
Personalizar tema de GNOME (manual).
Limpiar paquetes no utilizados.
Instalar herramientas de monitoreo (htop, gnome-system-monitor).
Instalar herramientas de compresión (unrar, p7zip-full).
Instalar VLC.
Habilitar Flatpak y Spotify.
Instalar fuentes Microsoft.
Actualizar .bashrc.

Notas

Algunas tareas (e.g., Luz Nocturna, ajustes de energía) requieren intervención manual y el script proporciona instrucciones.
El navegador Tor requiere instalación manual desde https://www.torproject.org/download/.
El URL de Mullvad Browser puede cambiar; verifica en https://mullvad.net/en/download/browser si falla.
Usa con precaución, especialmente al modificar /etc/apt/sources.list o .bashrc. Se crean respaldos automáticos.

Contribuir
¡Las contribuciones son bienvenidas! Por favor, crea un pull request o reporta problemas en la sección de Issues.
Licencia
Este proyecto está bajo la Licencia MIT. Consulta el archivo LICENSE para más detalles.
Autor

jadm2907 - https://github.com/jadm2907

