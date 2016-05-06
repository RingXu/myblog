#!/bin/bash
python /myblog/manage.py makemigrations
python /myblog/manage.py migrate
#/usr/local/bin/gunicorn myblog.wsgi:application -w 2 -b :8000
supervisord -c /etc/supervisord.conf