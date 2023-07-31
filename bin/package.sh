#!/bin/sh

## focus to current dir
CURRENT_DIR=$(dirname $(readlink -f "$0"))
cd "$CURRENT_DIR" || exit

cd ../

## build
mvn clean package
cd ruoyi-ui || exit
npm install --registry=https://registry.npm.taobao.org
npm run build:prod
cd ../

## copy to the released folder
rm -rf ../released
mkdir ../released
cp ./ruoyi-admin/target/ruoyi-admin.jar ../released/ruoyi-admin.jar
mkdir ../released/ruoyi-ui
cp -r ./ruoyi-ui/dist/* ../released/ruoyi-ui
cd ../released/ruoyi-ui && zip -r ../ruoyi-ui.zip ./*

cd ../../RuoYi-Vue
##mkdir ../released/config
##mkdir ../released/sql
cp -r ./sql ../released/sql
cp -r ./bin/auto-boot.sh ../released
cp -r ./bin/auto-install.sh ../released
cp -r ./bin/config ../released/config

##cp ./ruoyi-configmanage/target/ruoyi-configmanage.jar ../released/configmanage.jar
####cp -r ./ruoyi-configmanage-ui/dist/* ../released/configmanage-ui
##cp -r ./ruoyi-ui/dist/* ../released/cellxbase-ui
####cp -r ./bin/config/* ../released/config
####cd ../released/configmanage-ui && zip -r ../configmanage-ui.zip ./*
##cd ../cellxbase-ui && zip -r ../cellxbase-ui.zip ./*
