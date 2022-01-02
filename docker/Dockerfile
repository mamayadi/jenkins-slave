FROM docker:dind

ENV ROOT_PASS docker

COPY config/docker-entrypoint.sh /usr/local/bin/

RUN apk update \
        && apk add openssh openrc zip unzip nano \
        && openrc \
        && touch /run/openrc/softlevel \
        # && apk add py-pip \
        # && apk add py-pip python3-dev libffi-dev openssl-dev gcc libc-dev rust cargo make \
        # && pip install docker-py \
        # && pip3 install docker-compose \
        && echo "root:docker" | chpasswd \
        && sed -i '$a Port 22' /etc/ssh/sshd_config \
        && sed -i '$a PermitRootLogin yes' /etc/ssh/sshd_config \
        && chmod +x /usr/local/bin/docker-entrypoint.sh


EXPOSE 22
WORKDIR /home/docker
ENTRYPOINT ["docker-entrypoint.sh"]