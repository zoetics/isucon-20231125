#!/bin/bash -eux
sudo mysqldumpslow -s t /tmp/mysql-slow.sql
sudo bash -c "cat /var/log/nginx/access.log | /tmp/kataribe -f /tmp/kataribe.toml"