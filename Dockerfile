FROM sonarqube:6.2

ARG MAVEN_VERSION=3.3.9
ARG USER_HOME_DIR="/root"

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

VOLUME "$USER_HOME_DIR/.m2"

# update dpkg repositories to be able to install packages
RUN apt-get update

# install git
RUN apt-get install -y git

# install vim
RUN apt-get install -y vim

# Build image by "docker build -t sonarqube-maven-git ."
# run it as "docker run -d --name sonarqube-maven-git -p 9000:9000 -p 9092:9092 sonarqube-maven-git"
# step inside "docker exec -i -t sonarqube-maven-git /bin/bash"