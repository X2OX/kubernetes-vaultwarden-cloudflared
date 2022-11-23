FROM vaultwarden/server:latest

ENV WEBSOCKET_PORT=3012 \
    ROCKET_PORT=8080 \
    IP_HEADER="CF-Connecting-IP" \
    DATABASE_URL="/data/bitwarden.db"

RUN mkdir -p --mode=0755 /usr/share/keyrings
RUN curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | tee /usr/share/keyrings/cloudflare-main.gpg > /dev/null
RUN echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared bullseye main' | tee /etc/apt/sources.list.d/cloudflared.list


RUN apt-get update && apt-get -y --no-install-recommends install cron curl git nginx sqlite3 cloudflared


RUN git config --global user.name "kubernetes-vaultwarden-cloudflared[bot]"
RUN git config --global user.email "kubernetes-vaultwarden-cloudflared@x2ox.github.com"


WORKDIR /

COPY nginx.conf /etc/nginx/nginx.conf
COPY backup.sh backup.sh
COPY start.sh start.sh

CMD ["/start.sh"]