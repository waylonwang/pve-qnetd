FROM debian:bullseye
RUN echo 'debconf debconf/frontend select teletype' | debconf-set-selections
RUN apt-get update
RUN apt-get dist-upgrade -qy
RUN apt-get install -qy --no-install-recommends systemd systemd-sysv corosync-qnetd  openssh-server 
RUN apt-get clean

ENV container docker
STOPSIGNAL SIGRTMIN+3
VOLUME [ "/sys/fs/cgroup", "/run", "/run/lock", "/tmp" ]
CMD [ "/sbin/init" ]
