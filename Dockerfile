# Recommended in Atlassian Speech at Dockercon
FROM phusion/baseimage:0.9.11

# File Author / Maintainer
MAINTAINER Martin Taylor

# Update the repository sources list
RUN apt-get update && apt-get -y install python-software-properties

RUN add-apt-repository ppa:webupd8team/java

RUN apt-get update && apt-get -y upgrade

# automatically accept oracle license

RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

# and install java 7 oracle jdk

RUN apt-get -y install oracle-java7-installer && apt-get clean

RUN update-alternatives --display java

RUN echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/environment


# The end result of this job is to start running rice
RUN apt-get -y install tomcat7

RUN echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/default/tomcat7

RUN ln -s /var/lib/tomcat7/common /usr/share/tomcat7/common
RUN ln -s /var/lib/tomcat7/server/ /usr/share/tomcat7/server
RUN mkdir -p /var/lib/tomcat7/temp
RUN ln -s /var/lib/tomcat7/logs /usr/share/tomcat7/logs


EXPOSE 8080

CMD /usr/share/tomcat7/bin/catalina.sh run && tail -f /var/lib/tomcat7/logs/catalina.out


# RUN wget http://search.maven.org/remotecontent?filepath=org/kuali/rice/rice-sampleapp/2.4.2/rice-sampleapp-2.4.2.war -P /var/lib/tomcat7/webapps/rice-sampleapp
# Start Tomcat, after starting Tomcat the container will stop. So use a 'trick' to keep it running.
# CMD /usr/share/tomcat7/bin/catalina.sh run && tail -f /var/lib/tomcat7/logs/catalina.out
