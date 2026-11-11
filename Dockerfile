# پیک — Web Service روی Render با Docker، نه Background Worker.
FROM node:22-bookworm-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl ffmpeg python3 python3-pip \
 && ( curl -fL --retry 3 -o /usr/local/bin/yt-dlp \
        "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp_linux" \
      && chmod 755 /usr/local/bin/yt-dlp \
      && /usr/local/bin/yt-dlp --version ) \
    || pip3 install --break-system-packages -U yt-dlp \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY bot/ /app/
ENV NODE_ENV=production
CMD ["node", "index.mjs"]
