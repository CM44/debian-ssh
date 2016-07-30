FROM debian:latest

ENV SERVER_PASS root

RUN apt-get update \
    && apt-get install -y openssh-server \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && mkdir -p /var/run/sshd \
    && echo "root:${SERVER_PASS}" | chpasswd \
    && sed -ri 's/^PasswordAuthentication\s+.*/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && echo "PasswordAuthentication no" >>/etc/ssh/sshd_config \
    && echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQDGtw1yyUD5HWh1tc7PBDWYS+Mv9fAvDQNDm5PXERwVTf5b0KbQz0P4COIm3Dc3yXzDuyFQPvUt/x/p6JPWTKfE4OZOr2/9q0LKvGdjonp8F7wNJF73nHBQYMZOOz+McXBa88GBPoGVs9pFRU+weW3pq/HWNhT73fZaI6WKk25R1w==" >/root/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
