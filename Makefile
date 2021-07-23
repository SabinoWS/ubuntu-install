# TODO
## XFREERDP

# - Ubuntu with snapd
.ONESHELL:

readme:
	@printf "! Go to the README file !\n"

all: install configuration
install: install-apt install-snap install-wget install-docker
configuration: config-alias config-utilities config-ssh config-folders

# Manual ---------------------------------------------------------------
manual-zbash: # With oh my zsh framework
	@sudo apt install zsh --yes
	@sudo chsh -s /usr/bin/zsh
	@sh -c "$$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
	@echo "Log out and log in to finish!"

manual-vpn:
	@unrar x *.rar ~/Documents/vpn-files/
	@sudo nmcli connection import type openvpn file ~/Documents/vpn-files/*.ovpn
	@echo "Now you can enable the VPN in configurations!"



anbox:
# Kernel dependencies
	@sudo apt install software-properties-common --yes
# Load kernel modules
	@sudo modprobe ashmem_linux
	@sudo modprobe binder_linux

# Install ---------------------------------------------------------------
install-apt:
	@sudo apt update
	@sudo apt install apt-transport-https ca-certificates software-properties-common
	@sudo apt install snap git wget curl make unrar --yes
	@sudo apt install android-tools-adb --yes

install-snap:
	@sudo snap install --classic code
	@sudo snap install vim-editor --beta
	@sudo snap install htop
	@sudo snap install discord
	@sudo snap install eclipse --classic
	@sudo snap install intellij-idea-community --classic
	@sudo snap install dbeaver-ce
	@sudo snap install postman
	@sudo snap install flameshot
	@snap install --devmode --beta anbox
	
install-docker:
	@sudo apt-get update
	@sudo apt-get remove docker docker-engine docker.io containerd runc
	@curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	@sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
	@sudo apt update
	@apt-cache policy docker-ce
	@sudo apt install docker-ce --yes
	@sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$$(uname -s)-$$(uname -m)" -o /usr/local/bin/docker-compose
	@sudo chmod +x /usr/local/bin/docker-compose
	@sudo usermod -aG docker $${USER}
	@id -nG
	@echo "Reboot to use Docker without sudo!"

install-wget:
# Chrome
	@wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	@sudo apt install ./google-chrome-stable_current_amd64.deb
	@rm ./google-chrome-stable_current_amd64.*
# Mongo Compass
	@wget https://downloads.mongodb.com/compass/mongodb-compass_1.26.1_amd64.deb
	@sudo dpkg -i mongodb-compass_1.26.1_amd64.deb

install-dev:
# NVM - Node Version Manager
	@echo $$SHELL
	@wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | zsh
	@nvm install node
# SDKMan - Java Version Manager
	@curl -s "https://get.sdkman.io" | zsh
# Versions
	@echo "nvm install node"
	@echo "sdk install java 11.0.11.9.1-amzn"
	@echo "sdk install java 8.292.10.1-amzn"

# Configuration ---------------------------------------------------------------
config-folders:
	@mkdir ~/Documents/projetos

config-alias:
	@sudo echo 'alias zbash="code ~/.zshrc"' >> ~/.zshrc
	@sudo echo 'alias projetos="cd ~/Documents/projetos"' >> ~/.zshrc
	
config-utilities:
	@git config --global core.editor 'code --wait'
# Fire Shot - TODO
# 1 - Limpar atalho de printscreen
# 2 - Adiciona atalho para /snap/bin/flameshot gui
# Copy Queue - TODO

config-ssh:
	@ssh-keygen -q -t rsa -b 4096 -N '' -f ~/.ssh/id_rsa
	@printf "To show your key, run: cat ~/.ssh/id_rsa.pub\n"
#	@cat ~/.ssh/id_rsa.pub