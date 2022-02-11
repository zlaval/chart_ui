#!/bin/sh

ROOT_DIR=/usr/share/nginx/html

for file in $ROOT_DIR/js/app.*.js* $ROOT_DIR/index.html;
do
  sed -i 's|HOST_IP|'${HOST_IP}'|g' $file
  sed -i 's|HOST_PORT|'${HOST_PORT}'|g' $file
done

nginx -g 'daemon off;'