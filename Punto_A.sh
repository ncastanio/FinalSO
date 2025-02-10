VBoxManage cratehd --filename c:/user/54115/vagrant_examen/VirtualBox VMs/ubuntu_bionic/disk1.vdi --sixe 3074
# Comandos utilizados para crear la VM y configurar los discos:
#Apago la VM
vagrant halt
#Creo los discos 

VBoxManage createhd --filename "disk1.vdi" --size 3072 --format VDI
VBoxManage createhd --filename "disk2.vdi" --size 1024 --format VDI
VBoxManage createhd --filename "disk3.vdi" --size 1024 --format VDI
VBoxManage createhd --filename "disk4.vdi" --size 1024 --format VDI
VBoxManage storageattach "vagrant_examen_default_1738978487451_46597" --storagectl "SATA Controller" --port 1 --device 0 --type hdd --medium "disk1.vdi"
VBoxManage storageattach "vagrant_examen_default_1738978487451_46597" --storagectl "SATA Controller" --port 2 --device 0 --type hdd --medium "disk2.vdi"
VBoxManage storageattach "vagrant_examen_default_1738978487451_46597" --storagectl "SATA Controller" --port 3 --device 0 --type hdd --medium "disk3.vdi"
VBoxManage storageattach "vagrant_examen_default_1738978487451_46597" --storagectl "SATA Controller" --port 4 --device 0 --typ
