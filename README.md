# Soketi docker

A simple way to set up Soketi with a secure connection using a Let's Encrypt certificate.

## Setup

create an `.env` file:

```env
DOMAIN=ws.mydomain.com

SOKETI_DEFAULT_APP_ID=1
SOKETI_DEFAULT_APP_KEY=key
SOKETI_DEFAULT_APP_SECRET=secret
SOKETI_APP_CLUSTER=mt1
SOKETI_DEBUG=true
SOKETI_METRICS_ENABLED=true
```

start the docker containers:

```./start.sh```

## Debugging

View Soketi logs:

```
docker logs -f soketi
```

View caddy logs:
```
docker logs -f caddy
```
