#---------------------------------------------------#
#              Adapt to your distro.                 #
#          This pre-configured script uses           #
#             arch linux package manager             #
#---------------------------------------------------#
PACKAGE_MANAGER_UPDATE_COMMAND := sudo pacman -Syu
PACKAGE_MANAGER_INSTALL_PKG_COMMAND := sudo pacman -S
PACKAGE_MANAGER_REMOVE_PKG_COMMAND := sudo pacman -Rns
PACKAGE_MANAGER_SEARCH_PKG_COMMAND := pacman -Ss
PACKAGE_MANAGER_LOCAL_SEARCH_PKG_COMMAND := pacman -Qi

ALIAS_UPDATE_COMMAND := syu
ALIAS_INSTALL_PKG_COMMAND := pacs
ALIAS_REMOVE_PKG_COMMAND := rns
ALIAS_SEARCH_PKG_COMMAND := ss
ALIAS_LOCAL_SEARCH_PKG_COMMAND := qi

#---------------------------------------------------#
#            Your Git credentials here               #
#---------------------------------------------------#
GIT_USER_NAME :=
GIT_USER_EMAIL :=

#---------------------------------------------------#
#         Your Docker Hub credentials here           #
#---------------------------------------------------#
DOCKER_HUB_USER_NAME :=

update_system:
	@$(PACKAGE_MANAGER_UPDATE_COMMAND)

install_packages:
	@$(PACKAGE_MANAGER_INSTALL_PKG_COMMAND) base-devel \
		tree \
		git \
		docker \
		docker-compose \
		flatpak \
		ssh \
		gnupg \
		neofetch \
		vscodium \
		lua5.3 \
		luarocks-5.3 \
		intellij-community \
		jdk17-openjdk \
		jre17-openjdk \
		kitty \
		rustdesk \
		ollama \
		firefox

create_dirs:
	@mkdir -p ~/.ssh
	@mkdir -p ~/.gnupg
	@mkdir -p ~/Desktop/repos
	@mkdir -p ~/Documents/cv
	@mkdir -p ~/Pictures/wallpapers

create_alias:
	@grep -qxF 'alias repos="cd ~/Desktop/repos"' ~/.bashrc || echo 'alias repos="cd ~/Desktop/repos"' >> ~/.bashrc
	@grep -qxF 'alias ..="cd .."' ~/.bashrc || echo 'alias ..="cd .."' >> ~/.bashrc
	@grep -qxF 'alias $(ALIAS_UPDATE_COMMAND)="$(PACKAGE_MANAGER_UPDATE_COMMAND)"' ~/.bashrc || echo 'alias $(ALIAS_UPDATE_COMMAND)="$(PACKAGE_MANAGER_UPDATE_COMMAND)"' >> ~/.bashrc
	@grep -qxF 'alias $(ALIAS_INSTALL_PKG_COMMAND)="$(PACKAGE_MANAGER_INSTALL_PKG_COMMAND)"' ~/.bashrc || echo 'alias $(ALIAS_INSTALL_PKG_COMMAND)="$(PACKAGE_MANAGER_INSTALL_PKG_COMMAND)"' >> ~/.bashrc
	@grep -qxF 'alias $(ALIAS_REMOVE_PKG_COMMAND)="$(PACKAGE_MANAGER_REMOVE_PKG_COMMAND)"' ~/.bashrc || echo 'alias $(ALIAS_REMOVE_PKG_COMMAND)="$(PACKAGE_MANAGER_REMOVE_PKG_COMMAND)"' >> ~/.bashrc
	@grep -qxF 'alias $(ALIAS_SEARCH_PKG_COMMAND)="$(PACKAGE_MANAGER_SEARCH_PKG_COMMAND)"' ~/.bashrc || echo 'alias $(ALIAS_SEARCH_PKG_COMMAND)="$(PACKAGE_MANAGER_SEARCH_PKG_COMMAND)"' >> ~/.bashrc
	@grep -qxF 'alias $(ALIAS_LOCAL_SEARCH_PKG_COMMAND)="$(PACKAGE_MANAGER_LOCAL_SEARCH_PKG_COMMAND)"' ~/.bashrc || echo 'alias $(ALIAS_LOCAL_SEARCH_PKG_COMMAND)="$(PACKAGE_MANAGER_LOCAL_SEARCH_PKG_COMMAND)"' >> ~/.bashrc

git_config:
	@git config --global user.name "$(GIT_USER_NAME)"
	@git config --global user.email "$(GIT_USER_EMAIL)"

enable_docker_service:
	@sudo systemctl enable --now docker
	@sudo usermod -aG docker $(USER)

docker_hub_config:
	@sudo docker login -u $(DOCKER_HUB_USER_NAME)

all: update_system install_packages create_dirs create_alias git_config enable_docker_service docker_hub_config