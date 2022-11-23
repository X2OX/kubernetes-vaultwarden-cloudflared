#!/bin/sh

initGit() {
  git clone "$BACKUP_GIT_REPO" .

  if [ ! -f .gitignore ]; then
    touch .gitignore
  fi

  if [ $(grep -c "bitwarden.db" ".gitignore") -ne '0' ]; then
    echo "bitwarden.db" >>.gitignore
    echo "bitwarden.db-shm" >>.gitignore
    echo "bitwarden.db-wal" >>.gitignore
    echo "tmp" >>.gitignore
  fi

  if [ -f buckup.db ]; then
    cp buckup.db bitwarden.db
  fi
}

initGit
cat "$BACKUP_SCHEDULE bash /backup.sh" >/var/spool/cron/crontabs/root

/etc/init.d/cron start
/etc/init.d/nginx start
cloudflared service install "$CLOUDFLARED_TOKEN"



# Run
export WEBSOCKET_PORT=3012
export ROCKET_PORT=8080
export IP_HEADER="CF-Connecting-IP"
export DATABASE_URL="/data/bitwarden.db"

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
