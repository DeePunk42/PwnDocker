# docker build -t ctf:ubuntu20.04 .
# docker run --rm -v $PWD:/pwd --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -d --name ctf -i ctf:ubuntu20.04
# docker exec -it ctf /bin/bash

FROM ubuntu:20.04
ENV LC_CTYPE C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ADD ./sources.list /etc/apt
RUN dpkg --add-architecture i386 && apt-get update && apt-get -y upgrade
RUN apt-get install -y build-essential jq strace ltrace curl wget rubygems tmux gcc dnsutils netcat gcc-multilib net-tools vim gdb gdb-multiarch python python3 python3-pip python3-dev lib32z1 libssl-dev libc6-dev-i386 libffi-dev wget git make procps libpcre3-dev libdb-dev libxt-dev libxaw7-dev libc6:i386 libncurses5:i386 libstdc++6:i386 && \
pip install capstone requests pwntools r2pipe && \
pip3 install pwntools keystone-engine unicorn capstone ropper
RUN mkdir tools && cd tools && \
git clone https://github.com/JonathanSalwan/ROPgadget && \
git clone https://github.com/radare/radare2 && cd radare2 && sys/install.sh && \
cd .. && git clone https://github.com/pwndbg/pwndbg && cd pwndbg && ./setup.sh && \
gem install one_gadget
RUN  cd .. && git clone https://github.com/matrix1001/glibc-all-in-one && cd glibc-all-in-one && python3 update_list && \
cd ../tools && git clone https://github.com/NixOS/patchelf && cd patchelf && apt-get -y install autoconf automake libtool && ./bootstrap.sh && ./configure && make && make check && make install



