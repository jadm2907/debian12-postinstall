🛠️ Script de Post-Instalación para Debian 12 con GNOME
Este script en Bash automatiza tareas de configuración y optimización para Debian 12 con entorno GNOME. Proporciona un menú interactivo que permite ejecutar tareas específicas o todo el conjunto, con validaciones para evitar instalaciones redundantes.

✨ Características
🎛️ Menú interactivo: Ejecuta tareas individualmente o todas a la vez.

✅ Validaciones inteligentes: Detecta si los paquetes ya están instalados.

🌈 Mensajes en español: Instrucciones claras con retroalimentación en colores.

🔄 Instalación y desinstalación: Opciones para revertir los cambios donde sea posible.

🧱 Manejo de errores: Continuación en errores no críticos con mensajes explicativos.

📦 Tareas que realiza
🔄 Actualización del sistema y limpieza de paquetes no utilizados

📦 Habilitación de repositorios contrib y non-free

🌐 Instalación de 10 navegadores web:

Firefox ESR, Chromium, Google Chrome, Mullvad, Epiphany, Midori, Falkon, Qutebrowser, Surf, Lynx

(Tor Browser requiere instalación manual)

🧩 Configuración de extensiones GNOME (Dash to Dock, GNOME Shell Extensions)

🛠️ Instalación de herramientas: VLC, LibreOffice, GIMP, Flatpak, fuentes Microsoft

🔐 Configuración de seguridad: UFW, SSH, OpenVPN

🖥️ Personalización de .bashrc

🧹 Desinstalación y restauración de cambios

🧾 Requisitos
✅ Debian 12 con GNOME

🔐 Privilegios de sudo

🌐 Conexión a Internet

💻 Terminal Bash

🚀 Instalación
bash
Copy
Edit
git clone https://github.com/jadm2907/debian12-postinstall.git
cd debian12-postinstall
O descarga directa:

bash
Copy
Edit
wget https://github.com/jadm2907/debian12-postinstall.git
Haz el script ejecutable:

bash
Copy
Edit
chmod +x debian12_postinstalacion.sh
Ejecuta con sudo:

bash
Copy
Edit
sudo ./debian12_postinstalacion.sh
🧭 Uso
Al ejecutar el script, verás un menú interactivo con 29 opciones:

1-26: Ejecutan tareas individuales (actualización, instalación, configuración)

27: Ejecuta todas las tareas de instalación

28: Opción de desinstalación individual

29: Salir del script

🔔 Algunas tareas como habilitar Luz Nocturna requieren pasos manuales (con instrucciones en pantalla).

📋 Lista de Tareas Incluidas
✅ apt update && apt full-upgrade

📦 Habilitar contrib y non-free

🔧 Actualizar firmware

🛠️ Instalar GNOME Tweaks

🧩 GNOME Shell Extensions + Dash to Dock

🌅 Luz Nocturna (manual)

🎞️ Códecs multimedia

🌐 Navegadores web

🔥 Cortafuegos (UFW)

🧰 Synaptic, Déjà Dup

🔋 Ajustes de energía (manual)

💾 Controladores propietarios (manual)

☁️ Sincronización de archivos (manual)

🖥️ LibreOffice, GIMP

🔐 SSH y OpenVPN

🎨 Temas GNOME (manual)

🧹 Limpieza del sistema

📊 htop, system-monitor

📦 unrar, p7zip-full

🎥 VLC

🧩 Flatpak y Spotify

🅰️ Fuentes Microsoft

🖊️ Personalización de .bashrc

📝 Notas
⚠️ Algunas tareas (Luz Nocturna, controladores, etc.) requieren intervención manual.

🧠 Tor Browser debe instalarse desde torproject.org

🔄 El enlace de Mullvad puede cambiar: revisa mullvad.net

🗂️ Se crean respaldos automáticos de:

/etc/apt/sources.list

~/.bashrc

🛑 Usa con precaución, especialmente en sistemas críticos.

🤝 Contribuir
¡Las contribuciones son bienvenidas!

🐛 Reporta problemas en la sección Issues

📥 Envía Pull Requests con mejoras o correcciones

🧑‍💻 Sigue las convenciones de código del proyecto

📄 Licencia
Distribuido bajo la Licencia MIT.

👤 Autor
@jadm2907