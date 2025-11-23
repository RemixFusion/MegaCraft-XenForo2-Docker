# XenForo 2 with Docker
#### Modified by RemixF for MegaCraft

This is basic docker setup for XenForo 2. Changes by RemixF include:
- Upgrade to PHP 8.2
- Remapped HTTP port to 8003 (HTTP)
- Added port 9003 (HTTPS) for SSL and implemented new default.conf with certificate support
- Increased file_upload_size in Nginx to 128MB (Supports CloudFlare 100MB limit)
- Removed binding for MariaDB to restrict outside access

Installed:

- PHP (8.2 Default) 7.2.x, 8.0.x, 8.1.x, 8.2.x (Easily switch between PHP versions)

  - Mysqli
  - GD
  - Imagick
  - Composer
  - GMP
  - Zip

- Nginx: latest
- MariaDB: 10.6.3

## Structure

Put XenForo source code to folder `/xenforo`. Any new add-ons will be stored in folder `/addons`

- XenForo (internal_data, data) store at `.data/xenforo`
- Mariadb data store to `.data/mariadb`
- Nginx logging store to `.data/nginx`
- XenForo add-ons store at `/addons`

**Please take note of the directory which you use to store files. This directory, unlike most docker containers, uses local storage and if deleted will affect your XenForo installation.**

### Installation
 By default, this docker-compose.yml file will bind to ports `8003` and `9003` on all IP Addresses. This can be modified by editing ‘docker-compose.yml’ and specifying a different IP Address.

If you are using an SSL, upload your certificate to `.config/nginx/certs/`. The origin certificate should be named `origin.pem` and the private key should be named `origin.key`. You will need to modify the `default.conf` file located in `.config/nginx/conf.d/` and replace domain.com and www.domain.com with the domain associated with the certificate. Let’s Encrypt is not supported at this time, but you can utilize a custom SSL and/or CloudFlare Origin Certificate.
If you are not using an SSL, delete the `default.conf` located in `.config/nginx/conf.d/` and replace it with `default-no-ssl.conf.disabled`.

Clone this repository to your computer then run
`docker-compose build`

Upload your XenForo website to the `xenforo` folder which is located in the root directory, after cloning the repository. If you have any add-ons you wish to run, upload those to the `addons` folder.

Run `docker-compose up -d` to start the web server.

Please make sure that the Nginx and PHP containers have permissions set to allow the www-data user full access to all directories used by XenForo. This may result in errors, such as portions of the website not working, addons not being detected, and/or updates not installing correctly.

Open browser `http://domain.com:8003` and begin... (Replace domain.com with the domain or IP Address you are binding to. If you have configured a different port, please use this port)

## Install add-on

To store add-on directories correctly:

- Copy folder `/src/addons/<AddOnId>` to `/addons/<AddOnId>`
- Copy folder `/js/...` to `/xenforo/js/...`
- Copy folder `/styles/...` to `/xenforo/styles/...`

## config.php

Update your XenForo `config.php` with these values. Replace MARIADB_PASSWORD.

```php

$config['db']['host'] = 'mariadb';
$config['db']['port'] = '3306';
$config['db']['username'] = $_SERVER[‘xenforo2’];
$config['db']['password'] = $_SERVER['MARIADB_PASSWORD'];
$config['db']['dbname'] = $_SERVER[‘xenforo2’];

```

## .env

Update your `.env` with these values. Replace the MARIADB_ROOT_PASSWORD and MARIADB_PASSWORD.

``` MARIADB_ROOT_PASSWORD=changeme123
MARIADB_DATABASE=xenforo2
MARIADB_USER=xenforo2
MARIADB_PASSWORD=changeme456
```
