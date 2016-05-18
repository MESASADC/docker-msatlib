#
# *** CHANGES TO THIS FILE WILL BE OVERWRITTEN BY 'docker build' ***
#

FROM ubuntu:trusty
MAINTAINER Cheewai Lai <clai@csir.co.za>

ENV REFRESH_AT 201605

ENV DEBIAN_FRONTEND noninteractive

RUN sed 's/main$/main universe multiverse/' -i /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y apt-utils curl dialog less software-properties-common vim-tiny wget rsync net-tools iputils-ping lsof unzip

RUN /usr/sbin/useradd --create-home -u 1000 --password '9aMglX4Bvvhfw' --shell '/bin/bash' mesa

RUN apt-get install -y build-essential git python python-dev python-setuptools
RUN apt-get install -y openssh-server
RUN add-apt-repository ppa:ubuntugis/ubuntugis-unstable
RUN apt-get update
RUN apt-get install -y gdal-bin libgdal-dev python-gdal libmagick++-dev libgrib-api-dev dos2unix
RUN wget -q -O /tmp/meteosatlib-latest.tar.gz 'http://sourceforge.net/projects/meteosatlib/files/latest/download?source=files'
RUN tar -C /tmp -zxf /tmp/meteosatlib-latest.tar.gz
WORKDIR /tmp/meteosatlib-1.3
RUN wget -q -O decompress/PublicDecompWT.zip 'http://oiswww.eumetsat.org/wavelet/html/1404297436/PublicDecompWT.zip'
RUN chown -R mesa.mesa /tmp/meteosatlib-1.3
RUN su -c ./configure mesa
RUN su -c make mesa
RUN su -c 'make check' mesa
RUN make install
RUN ldconfig
RUN apt-get install -y python-pil python-scipy
# For cropping final output image
RUN apt-get install -y imagemagick

# Needed for GDAL to be able to find custom Meteosat image drivers
RUN echo 'GDAL_DRIVER_PATH=/usr/local/lib/gdalplugins/1.11' >>/etc/environment

VOLUME /main
VOLUME /home/mesa
CMD ["/main/start.sh"]
