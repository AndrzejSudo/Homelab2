#!/bin/bash

BACKUP_DIR="/mnt/pve/pi-backup/host-backups"
DATE=$(date +%F_%H-%M-%S)

mkdir -p "$BACKUP_DIR"

tar czf "$BACKUP_DIR/pve3-host-$DATE.tar.gz" \
    /etc/pve \
    /etc/network/interfaces \
    /etc/hosts \
    /etc/hostname \
    /etc/fstab \
    /etc/ssh \
    /etc/systemd/system \
    /etc/default \
    /etc/cron.d \
    /etc/cron.daily \
    /etc/cron.hourly \
    /etc/cron.monthly \
    /etc/cron.weekly \
    /root \
    2>/dev/null

echo "Backup created:"
echo "$BACKUP_DIR/pve3-host-$DATE.tar.gz"

dpkg --get-selections > /mnt/pve/pi-backup/host-backups/pve-config-backup/package-list.txt
apt-mark showmanual > /mnt/pve/pi-backup/host-backups/pve-config-backup/apt-installed-manually.txt
lsblk -f > /mnt/pve/pi-backup/host-backups/pve-config-backup/lsblk.txt
pvs > /mnt/pve/pi-backup/host-backups/pve-config-backup/pvs.txt
vgs > /mnt/pve/pi-backup/host-backups/pve-config-backup/vgs.txt
lvs -a > /mnt/pve/pi-backup/host-backups/pve-config-backup/lvs.txt
ip addr > /mnt/pve/pi-backup/host-backups/pve-config-backup/ip-address.txt
ip route > /mnt/pve/pi-backup/host-backups/pve-config-backup/ip-route.txt

echo "Configuration backedup:"
echo "$BACKUP_DIR/pve-config-backup"
