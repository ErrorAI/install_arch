#!/bin/bash

#создание gpt таблицы и разделов
(
  echo g; #создать gpt таблицу

  echo n; #новый раздел (разметим boot)
  echo;
  echo;
  echo +1G;

  echo n; #новый раздел (разметим swap)
  echo;
  echo;
  echo +8G;

  echo n; #новый раздел (остальное место под mnt(основной раздел))
  echo;
  echo;
  echo;
  
  echo t; #меняем тип 1го раздела на bios boot
  echo 1;
  echo 4;
  
  echo t; #меняем тип 2го раздела на linux swap
  echo 2;
  echo 19;

  echo w;
) | fdisk --wipe always /dev/sda


mkfs.ext2 /dev/sda1   #форматируем boot
mkswap /dev/sda2      #создаем swap
mkfs.ext4 /dev/sda3   #форматируем основной раздел
swapon /dev/sda2      #включаем swap
mount /dev/sda3 /mnt  #монтируем основной раздел в /mnt

reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist   #обновляем зеркала pacman
pacman -Sy  #обновляем репозитории pacman
pacstrap /mnt base base-devel linux linux-firmware dhcpcd grub sudo  #ставим систему и некоторые программы

genfstab -U /mnt >> /mnt/etc/fstab   #создаем файл fstab в основной раздел

cp arch-chroot-scr.sh /mnt/root/
arch-chroot /mnt /bin/bash -c "chmod +x /root/arch-chroot-scr.sh && /root/arch-chroot-scr.sh" &&
rm /mnt/root/arch-chroot-scr.sh

mkdir -p /home/user1/.config
cp CONFIG/_.config/* /home/user1/.config/
