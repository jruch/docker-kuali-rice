# Recommended in Atlassian Speech at Dockercon
FROM phusion/baseimage:0.9.11

# File Author / Maintainer
MAINTAINER Martin Taylor

## Notes: used tomcat7 docker recipe from Maluuba as starting point

# Update the repository sources list
EXPOSE 8080

RUN apt-get -qq update
RUN apt-get -y install openjdk-7-jre
RUN apt-get -y install tomcat7 
RUN apt-get -y install curl

ADD start-tomcat.sh /opt/start-tomcat.sh
RUN chmod +x /opt/start-tomcat.sh

RUN mv /etc/cron.daily/logrotate /etc/cron.hourly/logrotate

ADD logrotate /etc/logrotate.d/tomcat7
RUN chmod 644 /etc/logrotate.d/tomcat7

ENTRYPOINT ["/opt/start-tomcat.sh"]
