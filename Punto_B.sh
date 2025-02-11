# Comandos Utilizados en el punto B
# Creamos el  script para el chequeo de las URLs
sudo nano /usr/local/bin/castano_check_URL.sh



############################################################################################################################

# Escribimos el Script 
#!/bin/bash

# Parámetro: archivo de lista de URLs
URL_LIST="$1"

# Crear las carpetas necesarias
sudo mkdir -p /tmp/head-check/ok
sudo mkdir -p /tmp/head-check/Error/Cliente
sudo mkdir -p /tmp/head-check/Error/Servidor

# Función para verificar y registrar el estado de las URLs
check_url() {
    URL="$1"
    STATUS_CODE=$(curl -LI -o /dev/null -w '%{http_code}\n' -s "$URL")
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    LOG_LINE="$TIMESTAMP - Code:$STATUS_CODE - URL:$URL"

    # Registrar en /var/log/status_URL.log con sudo
    echo "$LOG_LINE" | sudo tee -a /var/log/status_URL.log

    # Clasificar y guardar el estado en la carpeta correspondiente
    DOMAIN=$(echo $URL | awk -F/ '{print $3}')
    if [[ $STATUS_CODE -eq 200 ]]; then
        echo "$LOG_LINE" >> /tmp/head-check/ok/$DOMAIN.log
    elif [[ $STATUS_CODE -ge 400 && $STATUS_CODE -lt 500 ]]; then
        echo "$LOG_LINE" >> /tmp/head-check/Error/Cliente/$DOMAIN.log
    elif [[ $STATUS_CODE -ge 500 && $STATUS_CODE -lt 600 ]]; then
        echo "$LOG_LINE" >> /tmp/head-check/Error/Servidor/$DOMAIN.log
    fi
}

# Leer la lista de URLs y verificar cada una
while IFS= read -r LINE; do
    if [[ "$LINE" != \#* ]] && [[ -n "$LINE" ]]; then
        URL=$(echo "$LINE" | cut -d';' -f2)
        check_url "$URL"
    fi
done < "$URL_LIST"
###################################################################################################





# Damos permiso de ejecuciòn  al  script
sudo chmod +x /usr/local/bin/castanio_check_URL.sh
# Ejecutar el script 
sudo /usr/local/bin/castanio_check_URL.sh ~/UTN-FRA_SO_Examenes/202408/bash_script/Lista_URL.txt

