#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

SSL_FOLDER="../ssl"

if [ -d "$SSL_FOLDER" ]; then
  echo "ssl folder existed"
else
  mkdir $SSL_FOLDER
fi

openssl genrsa -out $SSL_FOLDER/server.key 2048 && \
openssl req -new -key $SSL_FOLDER/server.key -out $SSL_FOLDER/server.csr && \
openssl x509 -req -days 365 -in $SSL_FOLDER/server.csr -signkey $SSL_FOLDER/server.key -out $SSL_FOLDER/server.crt

if [ $? -eq 0 ]; then
  printf "${GREEN}*** gen ssl success ***${NC} \n"
  rm -f $SSL_FOLDER/server.csr
else
  printf "${RED}??? gen ssl failed ???${NC} \n"
fi
