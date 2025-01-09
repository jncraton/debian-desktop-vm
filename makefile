all: debian.qcow2 debian.vdi

debian-12.img:
	virt-builder debian-12 --format raw --root-password password:password --install 'xfce4,build-essential,git,micro,sqlite3' --edit '/etc/lightdm/lightdm.conf: s/#autologin-user=/autologin-user=user/' --hostname aucs --firstboot-command 'useradd -m -p "" user'

debian.qcow2: debian-12.qcow2
	qemu-img convert -O qcow2 -c debian-12.qcow2 $@
	rm -f debian-12.qcow2

debian.vdi: debian.qcow2
	qemu-img convert -O vdi $< $@

clean:
	rm -f debian-12.qcow2 debian.qcow2
