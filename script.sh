#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

if ! grep -q "$$multilib$$" /etc/pacman.conf; then
    echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
    echo "Multilib repository added to /etc/pacman.conf"
else
    echo "Multilib repository is already enabled."
fi

pacman -Syu

echo "Multilib enabled and package database updated."


CONFIG_FILE="/etc/systemd/zram-generator.conf"


if ! grep -q "$$zram0$$" "$CONFIG_FILE"; then
    echo -e "\n[zram0]\nzram-size = ram * 2" >> "$CONFIG_FILE"
    echo "Added [zram0] configuration to $CONFIG_FILE"
else
    echo "[zram0] configuration already exists in $CONFIG_FILE."
fi


echo "Configuration updated."

systemctl restart systemd-zram-setup@zram0.service


sudo pacman -S fastfetch neofetch zsh timeshift firefox noto-fonts-cjk spectacle flatpak libreoffice-fresh kdenlive kvantum grub-btrfs mpv elisa virt-manager prismlauncher steam git zip unzip cmatrix cryfs enfs gocryptfs kdeconnect gwenview gparted partitionmanager jre17-openjdk jre21-openjdk jre8-openjdk kclock kolourpaint krita vlc power-profiles-daemon qbittorrent unrar zsh-autosuggestions wine

git clone https://aur.archlinux.org/yay.git

cd yay

makepkg -si

yay -S google-chrome spotify visual-studio-code-bin pfetch-rs vesktop-bin heroic-games-launcher-bin

sudo chsh -s /usr/bin/zsh


sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

cp -i .zshrc ~/.zshrc 

cp -i .p10k.zsh ~/.p10k.zsh



