#!/bin/bash

echo "
+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+
|b|a|c|k|u|p| |t|h|a|t| |s|q|l|
+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+
Este script:
- Se conecta por SSH a un servidor remoto
- Ejecuta un mysqldump de la base de datos, si falla da error
- Guarda el backup en tu local en la carpeta ~/backups
- Genera un archivo con fecha y hora en el nombre
- Imprime por pantalla la ruta del backup creado
- Muestra el tamaño del archivo generado
"

BACKUP_DATE=$(date +"%Y-%m-%d_%H-%M")
BACKUP_DIR="$HOME/backups"
DB_NAME="nombre_base_datos"
BACKUP_NAME="${DB_NAME}_${BACKUP_DATE}.sql"
SSH_USER="usuario_ssh"
SSH_HOST="servidor.com"
MYSQL_USER="usuario_mysql"
MYSQL_PASSWORD="password_mysql"

mkdir -p "$BACKUP_DIR"

ssh "$SSH_USER@$SSH_HOST" \
  "mysqldump -u $MYSQL_USER -p\"$MYSQL_PASSWORD\" $DB_NAME" \
  > "$BACKUP_DIR/$BACKUP_NAME"

if [ $? -ne 0 ]; then
  echo "Alerta! Error al crear el backup"
  exit 1
fi

echo "Backup creado: $BACKUP_DIR/$BACKUP_NAME"
du -h "$BACKUP_DIR/$BACKUP_NAME"
