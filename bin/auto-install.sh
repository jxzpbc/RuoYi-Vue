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


#install mysql

ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "dnf install -y @mysql"
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "systemctl start mysqld.service"
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "systemctl enable mysqld.service"
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "mkdir -p /root/sql"
scp -P "$remote_port" -i $ssh_key ./sql/quartz.sql "$remote_user"@"$remote_host":/root/sql/quartz.sql
scp -P "$remote_port" -i $ssh_key ./sql/ry_20230706.sql "$remote_user"@"$remote_host":/root/sql/ry_20230706.sql
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "mysql -uroot -e \"alter user user() identified by 'password'; use mysq l; update user set host='%' where user ='root'; flush privileges;\""
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "mysql -uroot -ppassword -e \"create database \\\`ry-vue\\\`;\""
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "mysql -uroot -ppassword -Dry-vue < /root/sql/quartz.sql"
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "mysql -uroot -ppassword -Dry-vue < /root/sql/ry_20230706.sql"


##install java
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "dnf install -y java-1.8.0-openjdk-devel.x86_64"

#install nginx
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "dnf install -y nginx"
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "systemctl start nginx.service"
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "systemctl enable nginx.service"

##install redis
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "dnf install -y redis"
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "systemctl start redis.service"
ssh -p "$remote_port" -i $ssh_key "$remote_user"@"$remote_host" "systemctl enable redis.service"

## remove ssh_key
rm -f $ssh_key
rm -f $ssh_key.pub
