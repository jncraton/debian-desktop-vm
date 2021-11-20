all: debian-11.qcow2

debian-11.qcow2:
	virt-builder debian-11 --format qcow2 --root-password password:password

clean:
	rm -f debian-11.qcow2
