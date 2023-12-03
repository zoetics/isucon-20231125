#!/bin/bash -eux

S1=isucon-app-1
S2=isucon-app-2
S3=isucon-app-3

APP_SERVICE=isupipe-go.service

# source fetch
pssh -H "${S1} ${S2} ${S3}" -i "cd /home/isucon/webapp; git pull"

# app build and restart
pssh -H "${S2} ${S3}" -i "cd /home/isucon/webapp/go; make; sudo systemctl daemon-reload && sudo systemctl restart ${APP_SERVICE}"

# nginx log clear and restart
pssh -H "${S2} ${S3}" -i "sudo rm -f /var/log/nginx/access.log /var/log/nginx/error.log && sudo systemctl daemon-reload && sudo systemctl restart nginx"

# db log clear and restart
pssh -H "${S1} ${S3}" -i "sudo rm -f /tmp/mysql-slow.sql && sudo systemctl daemon-reload && sudo systemctl restart mysql"

# pdns restart
pssh -H "${S3}" -i "sudo systemctl daemon-reload && sudo systemctl restart pdns.service"