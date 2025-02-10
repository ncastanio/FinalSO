# Final desde cero
#Creo la VM con Vagrant 
# Creo un nuevo directorio para el proyecto 
mkdir ~/vagrant_examen
cd ~/vagrant_examen
#inicializar vagrant en el nuevo directorio 
vagrant init ubuntu/bionic64
#arranco la VM
vagrant up
#conecto la VM
vagrant ssh 
#Actualizo el Sistema 
sudo apt-get update
sudo apt-get upgrade
#Instalo Git 
sudo apt-get install -y git
#Creo un usuario con la primera letra del nombre y apellido , dandole permiso sudo (sin clave) 
sudo adduser --disabled-password --gecos "" ncastanio
echo 'ncastanio ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/ncastanio
# cambiar al usuario ncastanio
sudo su - ncastanio
#clonar el repositorio github
git clone https://github.com/upszot/UTN-FRA_SO_Examenes.git
#Ejecutar el precondicion 
cd UTN-FRA_SO_Examenes/202408/script_Precondicion.sh
#Actualizar el archivo 
source ~/.bashrc
#Configuramos Git en el Home de usuario 
git config --global user.name "ncastanio"
git config --global user.mail "ncastanio@yahoo.com.ar"
#Creamos la carpeta RTA_Examen_$(date +%Y%m%d)
mkdir -p ~/RTA_Examen_$(date +%Y%m%d)
cd nombre del archivo "RTA_Examen20250207"
#Crear una archivo para cada unoo de los puntos del examen con los comandos utilizados para resolverlos 
echo "# Comandos utilizados  para resolver el punto A">Punto_A.sh
echo "# Comandos utilizados para resolver el punto B">Punto_B.sh
echo "# Comandos utilizados para resolver el  punto C">Punto_C.sh
echo "# Comandos utilizados para resolver el punto D">Punto_D.sh 
#Subir las respuesta a un repositorio propio de Github
git init
git add .
git commit -m "Respuesta del examen"
git remote add origin https://github.com/ncastanio/FinalSO.git
git push -u origin master 
usuario. ncastanio
Contraseña: app Github/configuracion/configuracion desarrolladores/token personal/token clasico/generar/copio/boton derecho 
