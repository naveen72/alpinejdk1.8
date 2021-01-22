FROM alpine:3.12
MAINTAINER NAVEEN KUMAR
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk \
    PATH=$PATH:$JAVA_HOME/bin \
    SPLUNK_HOME=/opt/splunk \
    PATH=$SPLUNK_HOME/bin:$PATH \
    DEBIAN_FRONTEND=noninteractive \
    LC_ALL=C.UTF-8 \
    LANG=en_GB.UTF-8 \
    LANGUAGE=en_GB.UTF-8
RUN apk update \
    && apk --no-cache add tzdata openjdk8 busybox-extras openssh-server openssh-client wget unzip tar ca-certificates procps \
    && cp /usr/share/zoneinfo/America/New_York /etc/localtime \
    && echo "America/New_York" > /etc/timezone \
    && echo 'root:alpinepassword' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && /usr/bin/ssh-keygen -A
WORKDIR /
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.29-r0/glibc-2.29-r0.apk \
    && apk add glibc-2.29-r0.apk \
    && rm -rf glibc-2.29-r0.apk
