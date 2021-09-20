#!/bin/bash
echo "yeeHost" > /etc/hostname

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "KEYMAP=ru" >> /etc/vconsole.conf
echo "FONT=cyr-sun16" >> /etc/vconsole.conf

mkinitcpio -p linux

grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

echo "Print root password:"
passwd

useradd -m -g users -G wheel -s /bin/bash user1
echo "Print user1 password:"
passwd user1

echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

pacman -Syy

pacman -S xorg-server xorg-drivers xorg-xinit virtualbox-guest-utils --noconfirm

pacman -S xfce4 xfce4-goodeis --noconfirm
pacman -S lxdm --noconfirm

systemctl enable lxdm
systemctl enable dhcpcd

pacman -S ttf-liberation ttf-dejavu --noconfirm

