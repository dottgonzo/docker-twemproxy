FROM yfix/baseimage

MAINTAINER Yuri Vysotskiy (yfix) <yfix.dev@gmail.com>

RUN apt-get update \
  && apt-get install -y \
    git-core \
    autoconf \
    automake \
    libtool \
    build-essential \
  \
  && cd /tmp \
  && git clone https://github.com/twitter/twemproxy \
  && cd twemproxy \
  && libtoolize --force \
  && aclocal \
  && autoheader \
  && automake --force-missing --add-missing \
  && autoconf \
  && ./configure --prefix=/usr/local/twemproxy --sbindir=/usr/local/sbin --datarootdir=/usr/local/share \
  && make \
  && make install \
  && mkdir /etc/twemproxy \
  \
  && apt-get purge -y --auto-remove \
    autoconf \
    automake \
    libtool \
    build-essential \
    autotools-dev \
    binutils \
    cpp \
    gcc \
  \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/* \
  && rm -rf /usr/{lib/share/{man,doc,info,gnome/help,cracklib},{lib,lib64}/gconv} \
  \
  && echo "====The end===="

#    ruby-dev \
#  && gem install nutcracker-web

ADD docker /

EXPOSE 6379 9292
#EXPOSE 6379 9292 22222

WORKDIR /opt
