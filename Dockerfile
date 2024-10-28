FROM nginx:1.26.2-alpine3.20 AS prod
EXPOSE 80
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY . /usr/share/nginx/html
RUN  rm -rf /usr/share/nginx/html/nginx
CMD [ "nginx", "-g", "daemon off;" ]