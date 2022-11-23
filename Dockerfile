FROM vaultwarden/server:latest

ENV WEBSOCKET_PORT=3012 \
    ROCKET_PORT=8080 \
    IP_HEADER="CF-Connecting-IP" \
    DATABASE_URL="/data/bitwarden.db"

RUN DEBIAN_FRONTEND=noninteractive apt -y install cron curl git nginx sqlite3

RUN git config --global user.name "kubernetes-vaultwarden-cloudflared[bot]"
RUN git config --global user.email "kubernetes-vaultwarden-cloudflared@x2ox.github.com"

# cloudflared
RUN arch=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/ | sed s/armel/arm/) && curl -L --output cloudflared.deb "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-${arch}.deb"
RUN dpkg -i cloudflared.deb && rm cloudflared.deb

WORKDIR /

RUN cp -f nginx.conf /etc/nginx/nginx.conf
RUN cp backup.sh backup.sh
RUN cp start.sh start.sh

CMD ["/start.sh"]