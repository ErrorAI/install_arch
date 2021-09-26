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
  
  echo t;
  echo 1;
  echo 4;
  
  echo t;
  echo 2;
  echo 19;

  echo w;
) | fdisk --wipe always /dev/sda


mkfs.ext2 /dev/sda1   &&
mkswap /dev/sda2      &&
mkfs.ext4 /dev/sda3   &&
swapon /dev/sda2      &&
mount /dev/sda3 /mnt  &&

pacman-key --refresh-keys
reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist   &&
pacstrap /mnt base base-devel linux linux-firmware dhcpcd vim grub sudo   &&

genfstab -U /mnt >> /mnt/etc/fstab   &&

cp arch-chroot-scr.sh /mnt/root/   &&
arch-chroot /mnt /bin/bash -c "chmod +x /root/arch-chroot-scr.sh && /root/arch-chroot-scr.sh" &&
rm /mnt/root/arch-chroot-scr.sh
