## Ejercicio B Docker
### Pasos Realizados
#Modificar index.html con tu nombre y apellido
  nano ~/UTN-FRA_SO_Examenes/202408/docker/web/index.html
# Construir la imagen de Docker con el nombre web3_ri2024-castanio
sudo docker build -t web3_ri2024-castanio ~/UTN-FRA_SO_Examenes/202408/docker
# Iniciar sesión en Docker Hub utilizando el token de acceso personal
echo <""> | sudo docker login --username ncastanio --password-stdin
# Etiquetar la imagen
sudo docker tag web3_ri2024-castanio ncastanio/web3_ri2024-castanio
# Subir la imagen
sudo docker push ncastanio/web3_ri2024-castanio
# Editar docker-compose.yml con el siguiente contenido
version: '3'
services:
  web:
    image: ncastanio/web3_ri2024-castanio
    ports:
      - "8081:80"
    volumes:
      - ./web/file:/usr/share/nginx/html/file
# Reemplazar el contenido de info.txt
echo "CPU Modelo: i5-8250U Frecuencia: 1.60GHz" > ~/UTN-FRA_SO_Examenes/202408/docker/web/file/info.txt
# Iniciar los contenedores
sudo docker-compose up -d
# Acceder a la aplicación
http://10.0.2.15:8081

