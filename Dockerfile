FROM ubuntu:16.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get -y update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  rm -rf /var/lib/apt/lists/*

RUN add-apt-repository -y universe
RUN apt-get -y update && apt-get install -y \
    curl \
    git \
    gnupg \
    python2.7 \
    vim

# s3fs to access s3 bucket for octaveaudio
RUN apt-get install -y s3fs 

ADD docker_scripts/python_install.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/python_install.sh
RUN bash /usr/local/bin/python_install.sh

ENTRYPOINT ["/bin/bash"]
