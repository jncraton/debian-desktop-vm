all: debian.qcow2 debian.vdi

debian-12.qcow2:
	virt-builder debian-12 --format qcow2 --root-password password:password --hostname au --firstboot-command 'useradd -m -p password user'

debian.qcow2: debian-12.qcow2
	qemu-img convert -O qcow2 -c debian-12.qcow2 $@
	rm -f debian-12.qcow2

debian.vdi: debian.qcow2
	qemu-img convert -O vdi $< $@

clean:
	rm -f debian-12.qcow2 debian.qcow2
