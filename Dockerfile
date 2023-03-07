FROM debian:bullseye
RUN echo 'debconf debconf/frontend select teletype' | debconf-set-selections
RUN apt-get update
RUN apt-get dist-upgrade -qy
RUN apt-get install -qy --no-install-recommends systemd systemd-sysv corosync-qnetd  openssh-server 
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /var/log/alternatives.log /var/log/apt/history.log /var/log/apt/term.log /var/log/dpkg.log
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo 'root:password' | chpasswd
RUN chown -R coroqnetd:coroqnetd /etc/corosync/
RUN systemctl mask -- dev-hugepages.mount sys-fs-fuse-connections.mount
RUN rm -f /etc/machine-id /var/lib/dbus/machine-id

ENV container docker
STOPSIGNAL SIGRTMIN+3
VOLUME [ "/sys/fs/cgroup", "/run", "/run/lock", "/tmp" ]
CMD [ "/sbin/init" ]
