# Docker WordPress

A Docker Compose stack for deploying WordPress using a Traefik proxy.

## Usage

1. Copy the sample file [.env.sample](.env.sample) as `.env` and fill in the missing information.

2. Create the network:

```bash
sudo docker network create web
sudo docker network create backend
sudo docker network create socket
```

3. Set correct permissions on `acme.json` file to allow Traefik to write certificates:

```bash
sudo chmod 600 traefik/acme.json
```

4. Build the stack:

```bash
sudo docker compose build --no-cache
```

5. Run the stack:

```bash
sudo docker compose up -d
```

## Systemd services

Copy and activate the Docker systemd service:

```bash
cp infra/systemd/docker-wordpress.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable docker-wordpress.service
sudo systemctl start docker-wordpress.service
```

## Generate WordPress salt

- Generate random salt: [https://api.wordpress.org/secret-key/1.1/salt/](https://api.wordpress.org/secret-key/1.1/salt/)
- Add values to the `.env` file

## SSL issues

WordPress may need `FORCE_SSL_ADMIN` to properly load stylesheets and force HTTPS in the admin dashboard:

```php
define('FORCE_SSL_ADMIN', true);

// If we're behind a proxy server and using HTTPS, we need to alert WordPress of that fact
// see also https://wordpress.org/support/article/administration-over-ssl/#using-a-reverse-proxy
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && strpos($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false) {
  $_SERVER['HTTPS'] = 'on';
}
```

## Restore a database

```bash
cat /path/to/dump.sql | sudo docker exec -i db mariadb -u root database-name
```
