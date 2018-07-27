FROM openjdk:8-jre-slim
RUN apt-get update \
&&  apt-get install -y \
      git \
      mplayer \
      tesseract-ocr tesseract-ocr-por tesseract-ocr-osd \
      libparse-win32registry-perl \
      libesedb-utils \
      graphicsmagick \
      libmsiecf-utils \
      libafflib-dev zlib1g-dev libewf-dev libvmdk-dev \
      libxtst6 libxi6 \
      libpff1 \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/*

#creates .mplayer/config
RUN mplayer

COPY --from=ipeddocker/sleuthkit:sleuthkit-4.6.0-patch01 /usr/local/src/sleuthkit/sleuthkit.tar.gz /tmp/
RUN tar xkf /tmp/sleuthkit.tar.gz -C /
RUN ldconfig

WORKDIR /opt
RUN git clone https://github.com/keydet89/RegRipper2.8.git
RUN echo '/usr/bin/perl /opt/RegRipper2.8/rip.pl "$@"' > /usr/bin/rip
RUN chmod +x /usr/bin/rip

COPY iped-3.14.3 /root/IPED
RUN echo tskJarPath = /usr/share/java/Tsk_DataModel.jar >> /root/IPED/LocalConfig.txt
