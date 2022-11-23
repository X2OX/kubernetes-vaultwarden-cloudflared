# kubernetes-vaultwarden-cloudflared

### Usage

- Vaultwarden ENV: https://github.com/dani-garcia/vaultwarden/blob/main/.env.template

ENV:
```env
BACKUP="Git"
BACKUP_SCHEDULE="0 0 3 * 1"
BACKUP_GIT_REPO="https://token@github.com/X2OX/kubernetes-vaultwarden-cloudflared.git"

CLOUDFLARED_TOKEN="token"
```

### TODO
- Rclone backup support

