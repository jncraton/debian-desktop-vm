all: debian-12-text.vdi.zip debian-12-text.qcow2 debian-12.vdi.zip debian-12.qcow2

text=\
  sudo \
  build-essential \
  git \
  micro \
  dhcpcd \
  sqlite3

gui=\
  xfce4 \
  xorg \
  lightdm \
  mousepad \
  thonny \
  firefox-esr

debian-12-text.img:
	virt-builder debian-12 \
	  --output $@ \
	  --format raw \
	  --root-password password:password \
	  --hostname aucs \
	  --run-command 'useradd -m -p "" user' \
	  --run-command 'chsh -s /bin/bash user' \
	  --copy-in 'user:/home' \
	  --run-command "apt update" \
	  --run-command "apt install -y --no-install-recommends ${text}" \
	  --run-command 'chown -R user:user /home/user' \
	  --run-command "usermod -aG sudo user"

debian-12.img:
	virt-builder debian-12 \
	  --output $@ \
	  --format raw \
	  --root-password password:password \
	  --copy-in 'user:/home' \
	  --hostname aucs \
	  --run-command 'useradd -m -p "" user' \
	  --run-command 'chsh -s /bin/bash user' \
	  --run-command "apt update" \
	  --run-command "apt install -y --no-install-recommends ${text} ${gui}" \
	  --run-command "usermod -aG sudo user" \
	  --run-command 'rm -rf /usr/share/backgrounds/*' \
	  --run-command 'chown -R user:user /home/user' \
	  --edit '/etc/lightdm/lightdm.conf: s/#autologin-user=/autologin-user=user/'

%.qcow2: %.img
	virt-sparsify --format raw --convert qcow2 --compress $< $@

%.vdi: %.img
	virt-sparsify --format raw --convert vdi $< $@

%.vdi.zip: %.vdi
	zip $@ $<

clean:
	rm -f *.img *.qcow2 *.vdi
