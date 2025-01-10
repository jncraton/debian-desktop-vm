all: debian-12.qcow2 debian-12.vdi

debian-12.img:
	virt-builder debian-12 --format raw --root-password password:password --install 'xfce4,build-essential,git,micro,sqlite3' --edit '/etc/lightdm/lightdm.conf: s/#autologin-user=/autologin-user=user/' --hostname aucs --firstboot-command 'useradd -m -p "" user' --run-command 'rm -rf /usr/share/backgrounds/*'

%.qcow2: %.img
	qemu-img convert -O qcow2 -c $< $@

%.vdi: %.img
	qemu-img convert -O vdi $< $@
	VBoxManage modifymedium --compact $@

clean:
	rm -f *.img *.qcow2 *.vdi
