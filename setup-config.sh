#!/bin/bash

echo "Configurando OJS para desenvolvimento..."

cp config.inc.php.example config.inc.php

# Substitui ou adiciona as linhas de configuração
sed -i.bak -E "s|^(host\s*=).*|\1 ${OJS_DB_HOST}|g" config.inc.php || echo "host = ${OJS_DB_HOST}" >> config.inc.php
sed -i.bak -E "s|^(username\s*=).*|\1 ${OJS_DB_USER}|g" config.inc.php || echo "username = ${OJS_DB_USER}" >> config.inc.php
sed -i.bak -E "s|^(password\s*=).*|\1 ${OJS_DB_PASSWORD}|g" config.inc.php || echo "password = ${OJS_DB_PASSWORD}" >> config.inc.php
sed -i.bak -E "s|^(name\s*=).*|\1 ${OJS_DB_NAME}|g" config.inc.php || echo "name = ${OJS_DB_NAME}" >> config.inc.php

echo "Configuração concluída."
