FROM daocloud.io/python:2.7
ADD requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt
RUN pip install supervisor
RUN apt-get update
RUN apt-get install -y nginx

RUN mkdir /myblog
WORKDIR /myblog
COPY . /myblog
RUN chmod +x docker-entrypoint.sh
RUN ln -s /myblog/nginx.conf /etc/nginx/sites-enabled/myblog
RUN rm /etc/nginx/sites-enabled/default
COPY supervisord.conf /etc/supervisord.conf
RUN mkdir /var/log/supervisor

EXPOSE 80

CMD /myblog/docker-entrypoint.sh


