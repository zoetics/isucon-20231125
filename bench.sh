#!/bin/bash -eux

# 使い方
# sudo ./bench.sh

echo 'exec provision'
(
  cd /home/isucon/webapp && git pull
)

# app & front
make -C /home/isucon/webapp/go
sudo bash -c "echo '' > /var/log/nginx/access.log && systemctl restart nginx && systemctl restart isupipe-go.service"

# db
sudo rm /tmp/mysql-slow.sql && sudo systemctl restart mysql

# 本番はcurlとかで代用したい
#echo 'exec bench'
#sudo -u isucon /home/isucon/benchmarker/bin/benchmarker -target localhost:443 -tls
#sudo -u isucon /home/isucon/private_isu/benchmarker/bin/benchmarker -u /home/isucon/private_isu/benchmarker/userdata -t http://localhost
#sleep 65

#echo 'exec analyse'
#sudo mysqldumpslow -s t /tmp/mysql-slow.sql
#sudo bash -c "cat /var/log/nginx/access.log | /tmp/kataribe -f /tmp/kataribe.toml"
#
#echo 'finish'