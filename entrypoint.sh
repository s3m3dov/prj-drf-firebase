#!/bin/sh
# This script checks if the container is started for the first time.

# Load .env variables
export "$(grep -vE "^(#.*|\s*)$" .env)"

# Check if the container is started for the first time.
CONTAINER_FIRST_STARTUP="CONTAINER_FIRST_STARTUP"
if [ ! -e /$CONTAINER_FIRST_STARTUP ]; then
    touch /$CONTAINER_FIRST_STARTUP
    python manage.py makemigrations accounts --check
    python manage.py makemigrations firebase_auth --check
    python manage.py migrate
    python manage.py createadmin --username $DJANGO_ADMIN_USERNAME --password $DJANGO_ADMIN_PASSWORD --noinput --email $DJANGO_ADMIN_EMAIL
else
    echo "This container has been started before, skipping first startup script."
fi
python manage.py runserver 0.0.0.0:8000
