all: debian-11.qcow2

debian-11.qcow2:
	virt-builder debian-11 --format qcow2 --root-password password:password --hostname au --install plymouth,gdm3 --upload gdm.conf:/etc/gdm3/daemon.conf

clean:
	rm -f debian-11.qcow2
