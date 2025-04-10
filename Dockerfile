FROM nginx:1.26.2-alpine3.20 AS prod

LABEL org.opencontainers.image.source=https://github.com/ASJordi/test-packages
LABEL org.opencontainers.image.description="asjordi-links"
LABEL org.opencontainers.image.licenses=MIT

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY . /usr/share/nginx/html

RUN  rm -rf /usr/share/nginx/html/nginx

EXPOSE 80

RUN apk --no-cache add curl

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

RUN chown -R appuser:appgroup /usr/share/nginx/html

USER appuser

HEALTHCHECK --interval=30s --timeout=3s --start-period=15s --retries=3 \
CMD curl -f http://localhost || exit 1

USER root
CMD [ "nginx", "-g", "daemon off;" ]
