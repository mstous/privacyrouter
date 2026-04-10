#!/bin/sh
# Backup configs + packages list

TIMESTAMP=$(date +%Y%m%d-%H%M)
BACKUP_DIR="/tmp/backup-$TIMESTAMP"

mkdir -p $BACKUP_DIR
cp /etc/config/* $BACKUP_DIR/ 2>/dev/null
apk list --installed > $BACKUP_DIR/installed_packages.txt
sysupgrade -l > $BACKUP_DIR/sysupgrade_list.txt

# Compress
tar czf /tmp/config-backup-$TIMESTAMP.tar.gz -C /tmp "backup-$TIMESTAMP"

echo "Backup saved: /tmp/config-backup-$TIMESTAMP.tar.gz"
echo "Upload via: scp root@192.168.1.1:/tmp/config-backup-*.tar.gz your-pc:/path/"
