# Configuration for proxmox backup server running on raspberry pi 4 with raspberry pi OS lite

### Backup HDD is connected to Pi via usb adapter, so first check if its detected by os and partition name
> lsblk

### Format hdd as ext4 and give it label
> sudo mkfs.ext4 /dev/sda1
> sudo e2label /dev/sda1 pve-backup

### Verify and check its UUID
> lsblk -f
> sudo blkid /dev/sda1

### Create backup directory
> sudo mkdir -p /srv/proxmox-backup

### Edit fstab
> sudo nano /etc/fstab

### Add in new line
> UUID=3abf9340-c0d3-40b1-82ac-3092165dfe73 /srv/pve-backups ext4 defaults,nofail,x-systemd.device-timeout=10s 0 2

### Test it, /dev/sda1 should be mounted as /srv/pve-backup
> sudo mount -a
> df -h

### Install NFS server
> sudo apt install nfs-kernel-server -y

### Create group and user for backup directory (required for proper root squash)
> sudo groupadd --system pvebackup
> sudo useradd --system --no-create-home -gid pvebackup pvebackup

### Grab UID/GID for backup user/group
> id pvebackup

### Edit exports, add new line for proxmox servers, add previous UID/GID as 'anonuid' and 'anongid'
> sudo nano /etc/exports
> /srv/pve-backups <host1_ip>(rw,sync,no_subtree_check,all_squash,anonuid=999,anongid=985) <host2_ip>(rw,sync,no_subtree_check,all_squash,anonuid=999,anongid=985
> sudo exportfs -ra && sudo exportfs -v

### Set up permissions and verify
> sudo chown -R pvebackup:pvebackup /srv/proxmox-backup
> sudo chmod 770 /srv/proxmox-backup
> ls -ld /srv/proxmox-backup

### Install tools to monitor hdd health
> sudo apt install smartmontools -y
> sudo smartctl -a /dev/sda

### On proxmox host, check NFS share
> showmount -e <backup_server_ip>

### Then create backup directory and mount it
> mkdir /mnt/backups-for-pi
> mount -t nfs <backup_server_ip>:/srv/proxmox-backup /mnt/backups-for-pi
> df -h /mnt/backups-for-pi

### In Proxmox VE, add Pi storage to datacenter
> Datacenter -> Storage -> Add -> NFS
> export: /srv/proxmox-backup
> content: Backup

### It should work now, so you can set up backup jobs
> Datacenter -> Backup -> Add
