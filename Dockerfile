FROM debian:bullseye
RUN echo 'debconf debconf/frontend select teletype' | debconf-set-selections


ENV container docker
STOPSIGNAL SIGRTMIN+3
VOLUME [ "/sys/fs/cgroup", "/run", "/run/lock", "/tmp" ]
CMD [ "/sbin/init" ]
