#!/bin/sh
# Restore from uploaded backup in temp
if [ $# -eq 0 ]; then
    echo "Usage: ./restore.sh config-backup-YYYYMMDD-HHMM.tar.gz"
    exit 1
fi
sysupgrade -r /tmp/$1
echo "✅ Restore complete. Rebooting..."
