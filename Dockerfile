FROM tomcat:9.0

ARG MAVEN_VERSION=3.6.3
ARG USER_HOME_DIR="/home/jenkins"
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN apt-get -qq -y update  && apt-get install -y -qq curl \
    zip \
    openssh-server \
    iproute2 \
    ssh \
    git \
    && apt-get clean

RUN service ssh start  \
    service ssh enable 

# Add jenkins user
RUN useradd --create-home --base-dir /home jenkins && \
    echo "jenkins:jenkins" | chpasswd && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    service ssh restart 

# Install maven
RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
    && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
    && rm -f /tmp/apache-maven.tar.gz \
    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

RUN ln -s /usr/local/openjdk-11 /usr/local/java

# Expose ports
EXPOSE 8080 22

# Default command
CMD [ "/usr/sbin/sshd", "-D" ]