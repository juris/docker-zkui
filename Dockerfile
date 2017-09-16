FROM maven:3.5-alpine
WORKDIR /usr/src/zkui
RUN apk add --no-cache git \
    && git clone --depth=1 https://github.com/DeemOpen/zkui.git . \
    && mvn clean install

FROM openjdk:8-jre-alpine
ENV LOGIN_MESSAGE="Default credentials: admin\/manager"
WORKDIR /var/app
COPY --from=0 /usr/src/zkui/target/zkui-2.0-SNAPSHOT-jar-with-dependencies.jar ./zkui.jar
COPY --from=0 /usr/src/zkui/config.cfg .
COPY --from=0 /usr/src/zkui/docker/bootstrap.sh .
EXPOSE 9090
ENTRYPOINT ["/var/app/bootstrap.sh"]
HEALTHCHECK --interval=30s --timeout=5s \
  CMD curl -f http://localhost:9090/ || exit 1
