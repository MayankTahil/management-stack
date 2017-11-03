FROM docker:stable-dind 

# docker run --privileged --name=sandbox -dt -v ./data:/data -v config:/kube/config mayankt/backdoor ; docker exec -it sandbox /bin/bash

RUN apk add --no-cache \
 sudo \
 curl \
 git \
 screen \
 htop \
 openssh \
 autossh \
 bash-completion \
 nano \
 tcpdump \
 coreutils && \
 # Generate host keys for sshd
 /usr/bin/ssh-keygen -A

# Install kubctl in the container and set default config file in /kube directory
WORKDIR /usr/local/bin
RUN  curl -O https://storage.googleapis.com/kubernetes-release/release/v1.7.1/bin/linux/amd64/kubectl && \
 chmod +x kubectl && mkdir /kube && \
 echo 'export KUBECONFIG=/kube/config' >> /etc/profile

# Set container to be a SSH host with pre-seeded SSH keys from git project and prohibit root logon.
RUN mkdir /var/run/sshd && mkdir /data && mkdir /keys && \
 echo 'root:screencast' | chpasswd && \
 sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/shadow && \
 echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
ENV NOTVISIBLE "in users profile"   
RUN echo "export VISIBLE=now" >> /etc/profile && export PATH=$PATH:/usr/sbin


COPY .backdoor/keys /keys
# Add unlocked user "admin" (sudo) and no ssh key retained.
RUN adduser -s /bin/bash -D admin && \
 adduser admin root && \
 echo "admin            ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers && \
 mkdir /home/admin/.ssh && \
 touch /home/admin/.ssh/authorized_keys && \
 cat /keys/admin/id_rsa.pub > /home/admin/.ssh/authorized_keys && \
 chown admin /home/admin/.ssh/* && \
 sed -i 's/admin:!:/admin::/g' /etc/shadow && \
 rm -rf /keys/admin

COPY ./backdoor/infinite.sh /tmp/infinite.sh

WORKDIR /data

EXPOSE 22
CMD /tmp/infinite.sh