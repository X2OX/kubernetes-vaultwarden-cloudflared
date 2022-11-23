#!/bin/bash

cd "/data"

if [ -f buckup.db ]; then
  rm backup.db
fi

sqlite3 /data/bitwarden.db "VACUUM INTO 'backup.db'"

git add .
git commit -m "Backup $(date '+%F-%H%M%S')"
git push
