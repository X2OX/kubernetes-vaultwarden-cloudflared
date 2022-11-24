#!/bin/bash

initGit() {
  git clone "$BACKUP_GIT_REPO" data

  if [ ! -f /data/.gitignore ]; then
    touch /data/.gitignore
  fi

  if [[ $(echo "/data/.gitignore" | grep "bitwarden.db") == "" ]]; then
    echo "bitwarden.db" >> /data/.gitignore
    echo "bitwarden.db-shm" >> /data/.gitignore
    echo "bitwarden.db-wal" >> /data/.gitignore
    echo "tmp" >> /data/.gitignore
  fi

  if [ -f /data/buckup.db ]; then
    cp /data/buckup.db /data/bitwarden.db
  fi
}

initGit
echo "$BACKUP_SCHEDULE bash /backup.sh" > /var/spool/cron/crontabs/root

/etc/init.d/cron start
/etc/init.d/nginx start

cloudflared tunnel --no-autoupdate run --token "$CLOUDFLARED_TOKEN" >> /dev/stdout 2>> /dev/stderr &


if [ -r /etc/vaultwarden.sh ]; then
    . /etc/vaultwarden.sh
fi

if [ -d /etc/vaultwarden.d ]; then
    for f in /etc/vaultwarden.d/*.sh; do
        if [ -r "${f}" ]; then
            . "${f}"
        fi
    done
fi

exec /vaultwarden "${@}"
