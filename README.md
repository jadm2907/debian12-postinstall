Script de Post-Instalación para Debian 12 con GNOME

Este script de Bash automatiza tareas de configuración y optimización para Debian 12 con el entorno de escritorio GNOME. Incluye un menú interactivo que permite ejecutar tareas de instalación o desinstalación de forma individual o todas a la vez, con validaciones para evitar instalaciones redundantes.

Características





Menú interactivo: Selecciona tareas específicas para instalar o desinstalar.



Validaciones: Comprueba si los paquetes ya están instalados antes de proceder.



Mensajes en español: Instrucciones claras con retroalimentación de progreso en colores.



Tareas incluidas:





Actualización del sistema y limpieza de paquetes no utilizados.



Habilitación de repositorios contrib y non-free.



Instalación de 10 navegadores web (Firefox ESR, Chromium, Google Chrome, Mullvad, Epiphany, Midori, Falkon, Qutebrowser, Surf, Lynx; Tor Browser requiere instalación manual).



Configuración de extensiones de GNOME (Dash to Dock, GNOME Shell Extensions).



Instalación de herramientas como VLC, LibreOffice, GIMP, Flatpak, y fuentes Microsoft.



Configuración de seguridad (cortafuegos UFW, SSH, OpenVPN).



Actualización de .bashrc para personalizar la terminal.



Desinstalación: Revierte cambios (donde sea posible) como eliminación de paquetes o restauración de configuraciones.



Manejo de errores: Mensajes claros para fallos y posibilidad de continuar tras errores no críticos.

Requisitos





Debian 12 con entorno GNOME instalado.



Privilegios de sudo.



Conexión a internet.



Terminal Bash.

Instalación





Clona el repositorio o descarga el script:

git clone https://github.com/jadm2907/debian12-postinstall.git
cd debian12-postinstall

O:

wget https://github.com/jadm2907/debian12-postinstall.git



Haz el script ejecutable:

chmod +x debian12_postinstalacion.sh



Ejecuta el script con sudo:

sudo ./debian12_postinstalacion.sh

Uso





Al ejecutar el script, se muestra un menú interactivo con 29 opciones:





1-26: Ejecuta tareas individuales de instalación (actualización del sistema, instalación de navegadores, etc.).



27: Ejecuta todas las tareas de instalación.



28: Desinstala una tarea específica.



29: Sale del script.



Sigue las instrucciones en pantalla para tareas manuales (e.g., habilitar Luz Nocturna).

Tareas Incluidas





Actualizar el sistema (apt update && apt full-upgrade).



Habilitar repositorios contrib y non-free.



Instalar actualizaciones de firmware.



Instalar GNOME Tweaks.



Instalar extensiones de GNOME Shell.



Instalar Dash to Dock.



Habilitar Luz Nocturna (manual).



Instalar códecs multimedia.



Instalar navegadores web (Firefox ESR, Chromium, Google Chrome, Mullvad, etc.).



Configurar cortafuegos (UFW).



Instalar Synaptic Package Manager.



Instalar herramienta de respaldo (Déjà Dup).



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





Algunas tareas (e.g., Luz Nocturna, ajustes de energía, controladores propietarios) requieren configuración manual; el script proporciona instrucciones.



El navegador Tor debe instalarse manualmente desde https://www.torproject.org/download/.



El URL de Mullvad Browser (versión 12.5.7) puede cambiar; verifica en https://mullvad.net/en/download/browser si falla.



Se crean respaldos automáticos de /etc/apt/sources.list y ~/.bashrc antes de modificarlos.



Usa el script con precaución, especialmente en sistemas críticos, y revisa los cambios propuestos.

Contribuir

¡Las contribuciones son bienvenidas! Por favor:





Reporta problemas en la sección de Issues.



Envía pull requests con mejoras o correcciones.



Sigue las convenciones de código del proyecto.

Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo LICENSE para más detalles.

Autor





jadm2907 - GitHub
