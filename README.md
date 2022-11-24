# kubernetes-vaultwarden-cloudflared

## Usage

### **Do not overwrite**

- `DATA_FOLDER`: Main data folder, hardcoded in the script
- `DATABASE_URL`: Database URL, hardcoded in the script
- `IP_HEADER`: Client IP Header, change will give an error getting the IP of the client
- `WEBSOCKET_ADDRESS`: Controls the WebSocket server address, hardcoded in the script
- `WEBSOCKET_PORT`: Controls the WebSocket server port, hardcoded in the script
- `ROCKET_ADDRESS`: Server listen address, hardcoded in the script
- `ROCKET_PORT`: Server listen port, hardcoded in the script
- `ROCKET_TLS`: TLS setting, use [Cloudflared](https://github.com/cloudflare/cloudflared)
- `I_REALLY_WANT_VOLATILE_STORAGE`: Alert about not having a persistent self defined volume, don't care

### You need to set

#### Vaultwarden
- `DOMAIN`: Domain settings
- `SHOW_PASSWORD_HINT`: This provides unauthenticated access to potentially sensitive data
- more https://github.com/dani-garcia/vaultwarden/blob/main/.env.template

#### Cloudflared
- `CLOUDFLARED_TOKEN`: Cloudflare Tunnel token

#### Backup setting
- `BACKUP`: `Git`, there may be more in the future
- `BACKUP_SCHEDULE`: `1 * * * *`, scheduled tasks for backup
- `BACKUP_GIT_REPO`: `https://token@github.com/owner/repo.git`, Backup/Data Repository

### TODO
- Rclone backup support
