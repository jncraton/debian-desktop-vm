all: debian.qcow2 debian.vdi

debian-11.qcow2:
	virt-builder debian-11 --format qcow2 --root-password password:password --hostname au --firstboot-command 'useradd -m -p password user'

debian.qcow2: debian-11.qcow2
	qemu-img convert -O qcow2 -c debian-11.qcow2 $@
	rm -f debian-11.qcow2

debian.vdi: debian.qcow2
	qemu-img convert -O vdi $< $@

clean:
	rm -f debian-11.qcow2 debian.qcow2
