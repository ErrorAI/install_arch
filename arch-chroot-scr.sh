#!/bin/bash
echo "yeeHost" > /etc/hostname    #записать имя хоста

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen   
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen         #генерируем локали

echo "LANG=en_US.UTF-8" > /etc/locale.conf      #выставляем язык системы

echo "KEYMAP=ru" >> /etc/vconsole.conf          #настройки отображения в консоли
echo "FONT=cyr-sun16" >> /etc/vconsole.conf     

mkinitcpio -p linux

grub-install /dev/sda                 #установка grub
grub-mkconfig -o /boot/grub/grub.cfg

echo "Print root password:"
passwd

useradd -m -g users -G wheel -s /bin/bash user1
echo "Print user1 password:"
passwd user1

echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

pacman -Syy
pacman -S vim --noconfirm
pacman -S xorg-server xorg-drivers xorg-xinit virtualbox-guest-utils --noconfirm

pacman -S xfce4 xfce4-goodies --noconfirm
pacman -S lxdm --noconfirm

systemctl enable lxdm
systemctl enable dhcpcd

pacman -S ttf-liberation ttf-dejavu --noconfirm

