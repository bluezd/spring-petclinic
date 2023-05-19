FROM registry.suse.com/bci/openjdk:latest as runtime
EXPOSE 8080

ENV APP_HOME /app
ENV JAVA_OPTS=""

RUN mkdir $APP_HOME
# store externalized config files and logs
RUN mkdir $APP_HOME/config
RUN mkdir $APP_HOME/log

VOLUME $APP_HOME/config
VOLUME $APP_HOME/log

COPY ./target/*.jar $APP_HOME/app.jar

WORKDIR $APP_HOME

ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar app.jar $0 $@" ]
