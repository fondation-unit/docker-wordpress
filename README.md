# Docker WordPress

A Docker Compose stack for deploying WordPress using a Traefik proxy, based on the official WordPress image.

## Usage

### Local:

- Download and extract WordPress sources in [wordpress/src](./wordpress/src/)
- Run the local docker-compose stack: `docker-compose -f docker-compose-local.yml up`

### Production:

1. Set correct permissions on `acme.json` file to allow Traefik to write certificates:

```sh
chmod 600 traefik/acme.json
```

WordPress may need `FORCE_SSL_ADMIN` to properly load stylesheets and force HTTPS in the admin dashboard:

```php
define('FORCE_SSL_ADMIN', true);

// If we're behind a proxy server and using HTTPS, we need to alert WordPress of that fact
// see also https://wordpress.org/support/article/administration-over-ssl/#using-a-reverse-proxy
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && strpos($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false) {
 $_SERVER['HTTPS'] = 'on';
}
```
