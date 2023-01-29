#!/bin/bash

mkcert "*.terpusat.com"

mkcert -install

mv _wildcard.terpusat.com-key.pem terpusat.com-key.pem
mv _wildcard.terpusat.com.pem terpusat.com.pem