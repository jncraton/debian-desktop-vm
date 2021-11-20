all: debian.qcow2

debian-11.qcow2:
	virt-builder debian-11 --format qcow2 --root-password password:password --hostname au --firstboot-command 'useradd -m -p password user' --install gdm3 --upload gdm.conf:/etc/gdm3/daemon.conf

debian.qcow2: debian-11.qcow2
	qemu-img convert -O qcow2 -c debian-11.qcow2 $@
	rm -f debian-11.qcow2

clean:
	rm -f debian-11.qcow2 debian.qcow2
