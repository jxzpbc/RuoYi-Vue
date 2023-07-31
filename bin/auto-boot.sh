#!/bin/sh

remote_host=
remote_user="root"
remote_port="22"
ssh_key=~/.ssh/id_rsa_ruoyi_temp

showHelp() {
  echo "Usage: sh ./auto-boot.sh [OPTIONS]"
  echo "Options:"
  echo "  -h <ssh host>"
  echo "  -p <ssh port>"
  echo "  -u <ssh user>"
  exit;
}

while getopts "h:p:u:" opt; do
  case "$opt" in
    h ) remote_host=$OPTARG ;;
    p ) remote_port=$OPTARG ;;
    u ) remote_user=$OPTARG ;;
    ? ) showHelp ;;
  esac
done

## 生成key
ssh-keygen -m PEM -t rsa -N '' -f $ssh_key

## 登录服务器
ssh-copy-id -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host"


## firewall
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "setenforce 0"
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "systemctl stop firewalld.service"
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "systemctl disable firewalld.service"

## upload jar
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "mkdir -p /root/jars"
scp -P "$remote_port" -i $ssh_key ./ruoyi-admin.jar "$remote_user"@"$remote_host":/root/jars/ruoyi-admin.jar

## upload ui
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "mkdir -p /root/zips"
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "rm -rf /usr/share/ruoyi-ui/"
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "mkdir -p /usr/share/ruoyi-ui"
scp -P "$remote_port" -i $ssh_key ./ruoyi-ui.zip "$remote_user"@"$remote_host":/root/zips/
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "unzip /root/zips/ruoyi-ui.zip -d /usr/share/ruoyi-ui"

## upload config
scp -P "$remote_port" -i $ssh_key ./config/ruoyi-admin.service "$remote_user"@"$remote_host":/usr/lib/systemd/system/
scp -P "$remote_port" -i $ssh_key ./config/ruoyi.nginx.http.conf "$remote_user"@"$remote_host":/etc/nginx/conf.d/
scp -P "$remote_port" -i $ssh_key ./config/nginx.conf "$remote_user"@"$remote_host":/etc/nginx/

## restart nginx and service
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "systemctl daemon-reload"
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "systemctl enable ruoyi-admin.service"
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "systemctl restart ruoyi-admin.service"
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "systemctl restart nginx"

## remove ssh_key
rm -f $ssh_key
rm -f $ssh_key.pub
