#!/bin/bash
sfdisk -l             &&
mkfs.ext2 /dev/sda1   &&
mkswap /dev/sda2      &&
mkfs.ext4 /dev/sda3   &&
swapon /dev/sda2      &&
mount /dev/sda3 /mnt  &&
reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist   &&
pacstrap /mnt base base-devel linux linux-firmware dhcpcd vim grub sudo   &&

genfstab -U /mnt >> /mnt/etc/fstab   &&

cp arch-chroot-scr.sh /mnt/root/   &&
arch-choot /mnt /bin/bash -c "chmod +x /root/arch-chroot-scr.sh && /root/arch-chroot-scr.sh" &&
rm /mnt/root/arch-chroot-scr.sh
