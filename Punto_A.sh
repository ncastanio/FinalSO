# Comandos utiliados para resolver el punto A
# Apagamos la VM
vagrant halt 
# Creamos los disco

VBoxManage createhd --filename c:/users/54115/vagrant_examen/VirtualBox VMs/ubuntu_bionic/disk1.vdi --sixe 3072
VBoxManage createhd --filename c:/users/54115/vagrant_examen/VirtualBox VMS/ubuntu_bionic/disk2.vdi --size 1024
VBoxManage createhd --filename c:/users/54115/vagrant_examen/VirtualBox VMs/ubuntu_bionic/disk3.vdi --size 1024 
# Crear Disco de defensa
VBoxManage createhd --filename c:/users/54115/vagrant_examen/VirtualBox VMs/ubuntu_bionic/disk4.vdi --size 1024 
# Conectar los discos a la VM
VBoxManage storageattach "vagrant_examen_default_1738978487451_46597" --storagectl "SCSI" --port 2 --device 0 --type hdd --medium "c:/users/54115/vagrant_examen/VirtualBox VMs/ubuntu_bionicdisk1.vdi"
VBoxManage storageattach "vagrant_examen_default_1738978487451_46597" --storagectl "SCSI" --port 3 --device 0 --type hdd --medium "c:/users/54115/vagrant_examen/VirtualBox VMs/ubuntu_bionic/disk2.vdi"
VBoxManage storageattach "vagrant_examen_default_1738978487451_46597" --storagectl "SCSI" --port 4 --device 0 --type hdd --medium "c:/users/54115/vagrant_examen/VirtualBox VMs/ubuntu_bionic/disk3.vdi"
VBoxManage storageattach "vagrant_examen_default_1738978487451_46597" --storagectl "SCSI" --port 5 --device 0 --type hdd --medium "c:/users/54115/vagrant_examen/VirtualBox VMs/ubuntu_bionic/disk4.vdi"
# Levantamos la virtual 
vagrant up 
# Conectamos la VM
vagrant ssh
# Comprobaamos los discos 
lsblk
# Creamos la particion 
sudo fdisk /dev/sdc /dev/sdd /dev/sde /dev/sdf
# Opciones: n, p, 1, enter, enter, t, 8e, w
# Opciones para el disco de defensa (sdf): n, p, 1, enter, enter, w
# Configuraciò de LVM
sudo pvcreate /dev/sdc1 /dev/sdd1 /dev/sde1
sudo vgcreate vg_datos /dev/sdc1 /dev/sdd1
sudo vg_temp /dev/sde1
sudo lvcreate -L 10M -n lv_docker vg_datos
sudo lvcreate -L 1.5G -n lv_multimedia vg_datos
sudo lvcreate -L 512MB -n lv_swap vg_temp
# Formatear y montar volumenes 
sudo mkfs.ext4 /dev/vg_datos/lv_docker
sudo mkfs.ext4 /dev/vg_datos/lv_multimedia
sudo mkswap /dev/vg_temp/lv_swap
sudo swapon /dev/vg_temp/lv_swap
#Crear directorio de montaje
sudo mkdir -p /var/lib/docker
sudo mkdir -p /multimedia
#Montar los volumenes logicos 
sudo mount /dev/vg_datos/lv_docker/var/lib/docker
sudo mount /dev/vg_datos/lv_multimedia/multimedia
# Agregar montajes al archivo fstab
sudo nano /etc/fstab
#Añadir lo siguiente: 
/dev/vg_datos/lv_docker/var/lib/docker ext4 default 0 2
/dev/vg_datos/lv_multimedia/multimedia ext4 default 0 2
/dev/vg_temp/lv_swap none swap sw 0 0


