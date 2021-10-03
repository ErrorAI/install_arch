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

echo "Print root password:"           #пароль для root
passwd

useradd -m -g users -G wheel -s /bin/bash user1   #новый пользователь user1
echo "Print user1 password:"                      #пароль для user1
passwd user1

echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers       #разрешаем группе wheel использовать sudo

pacman -Syy       #обновляем зеркала pacman 

pacman -S vim --noconfirm
pacman -S git --noconfirm
pacman -S firefox --noconfirm
pacman -S thunderbird --noconfirm

pacman -S xorg-server xorg-drivers xorg-xinit virtualbox-guest-utils --noconfirm      #ставим Xorg исксы
pacman -S xfce4 xfce4-goodies --noconfirm             #ставим окружение графическое
pacman -S lxdm --noconfirm                            #ставим менеджер входа

systemctl enable lxdm      #включаем менеджер как демона
systemctl enable dhcpcd    #включаем демон dhcpcd

pacman -S ttf-liberation ttf-dejavu --noconfirm    #ставим рекомендуемые шрифты с поддержкой кирилицы

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -Rf yay
