# XenForo 2 with Docker
#### Changes by RemixF with SSL

This is basic docker setup for XenForo 2. Changes by RemixF include:
- Remapped HTTP port to 8003 (HTTP)
- Added port 9003 (HTTPS) for SSL
- Increased file_upload_size in Nginx to 128MB (Supports CloudFlare 100MB limit)

Installed:

- PHP (8.2 Default) 7.2.x, 8.0.x, 8.1.x, 8.2.x (Easily switch between PHP versions)

  - Mysqli
  - GD
  - Imagick
  - Composer
  - GMP
  - Zip

- Nginx: latest
- Mariadb: 10.6.3

## Structure

Put XenForo source code to folder `/xenforo`. Any new add-ons will be stored in folder `/addons`

- XenForo (internal_data, data) store at `.data/xenforo`
- Mariadb data store to `.data/mariadb`
- Nginx logging store to `.data/nginx`
- XenForo add-ons store at `/addons`

**Please take note of the directory which you use to store files. This directory, unlike most docker containers, uses local storage and if deleted will affect your XenForo installation.**

### Installation

This requires open port `8003` and `9003` make sure the port was allowed in your environment. You can change the port to any other
by editing the file `docker-compose.yml`

Clone this repository to your computer then run
`docker-compose build`

to build images and run `docker-compose up -d` to start web server.

Open browser `http://localhost:8023` and begin... (If you have configured a different port, please use this port)

## Install add-on

To store add-on directories correctly:

- Copy folder `/src/addons/<AddOnId>` to `/addons/<AddOnId>`
- Copy folder `/js/...` to `/xenforo/js/...`
- Copy folder `/styles/...` to `/xenforo/styles/...`

## config.php

Update your XenForo `config.php` with these values.

```php

$config['db']['host'] = 'mariadb';
$config['db']['port'] = '3306';
$config['db']['username'] = $_SERVER['MARIADB_USER'];
$config['db']['password'] = $_SERVER['MARIADB_PASSWORD'];
$config['db']['dbname'] = $_SERVER['MARIADB_DATABASE'];

```
