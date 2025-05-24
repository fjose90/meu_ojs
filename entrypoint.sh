#!/bin/bash
set -e

# Espera o banco subir
echo "Aguardando banco de dados..."
until mysql -h db -u ojs_user -pojs_pass -e 'SELECT 1'; do
  >&2 echo "MySQL está indisponível - aguardando..."
  sleep 3
done

echo "MySQL está pronto."

# Se o OJS ainda não foi instalado, instale
if [ ! -f "/var/www/html/config.inc.php" ]; then
  echo "Instalando OJS automaticamente..."
  php tools/install.php \
    --admin_username=admin \
    --admin_password=admin \
    --admin_email=admin@example.com \
    --locale=pt_BR \
    --client_charset=utf-8 \
    --connection_charset=utf8 \
    --database_charset=utf8 \
    --dbdriver=mysqli \
    --dbname=ojs \
    --dbuser=ojs_user \
    --dbpassword=ojs_pass \
    --dbhost=db \
    --files_dir=/var/www/ojs_files
else
  echo "OJS já está instalado."
fi

# Executa o comando padrão do container
exec apache2-foreground
