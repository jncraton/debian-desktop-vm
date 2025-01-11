all: debian-12-text.vdi.zip debian-12-text.qcow2 debian-12.vdi.zip debian-12.qcow2

debian-12-text.img:
	virt-builder -v -x debian-12 --output $@ --format raw --root-password password:password --hostname aucs --firstboot-command 'useradd -m -p "" user'  --copy-in 'user:/home' --install "build-essential,git,micro,sqlite3"

debian-12.img:
	virt-builder debian-12 --output $@ --format raw --root-password password:password --copy-in 'user:/home' --install 'xfce4,build-essential,git,micro,sqlite3' --edit '/etc/lightdm/lightdm.conf: s/#autologin-user=/autologin-user=user/' --hostname aucs --firstboot-command 'useradd -m -p "" user' --run-command 'rm -rf /usr/share/backgrounds/*'

%.qcow2: %.img
	virt-sparsify --format raw --convert qcow2 --compress $< $@

%.vdi: %.img
	virt-sparsify --format raw --convert vdi $< $@

%.vdi.zip: %.vdi
	zip $@ $<

clean:
	rm -f *.img *.qcow2 *.vdi
