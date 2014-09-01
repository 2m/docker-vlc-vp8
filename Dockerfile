FROM martynas/ssh:latest
MAINTAINER Martynas Mickevicius <mmartynas@gmail.com>

RUN apt-get update
RUN apt-get install -y build-essential autoconf libtool pkg-config gettext

WORKDIR /opt
RUN git clone git://github.com/yasm/yasm.git
WORKDIR /opt/yasm
RUN git checkout v1.2.0
RUN ./autogen.sh
RUN make
RUN make install

WORKDIR /opt
RUN wget http://downloads.xiph.org/releases/ogg/libogg-1.3.0.tar.gz
RUN tar xzvf libogg-1.3.0.tar.gz
WORKDIR /opt/libogg-1.3.0
RUN ./configure
RUN make
RUN make install

WORKDIR /opt
RUN wget http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.3.tar.gz
RUN tar xzvf libvorbis-1.3.3.tar.gz
WORKDIR /opt/libvorbis-1.3.3
RUN ./configure
RUN make
RUN make install

WORKDIR /opt
RUN git clone http://git.chromium.org/webm/libvpx.git
WORKDIR /opt/libvpx
RUN ./configure --enable-pic
RUN make
RUN make install

WORKDIR /opt
RUN git clone git://source.ffmpeg.org/ffmpeg.git
WORKDIR /opt/ffmpeg
RUN ./configure --enable-pic --enable-libvpx --enable-libvorbis
RUN make
RUN make install

WORKDIR /opt
RUN wget http://liba52.sourceforge.net/files/a52dec-0.7.4.tar.gz
RUN tar xzvf a52dec-0.7.4.tar.gz
WORKDIR /opt/a52dec-0.7.4
RUN ./configure CFLAGS="-fPIC"
RUN make
RUN make install

WORKDIR /opt
RUN git clone git://git.videolan.org/vlc.git
WORKDIR /opt/vlc
RUN ./bootstrap
RUN ./configure --disable-lua --disable-mad --without-x --disable-glx --disable-skins2 --disable-xvideo --disable-dbus --disable-sdl --disable-xcb --disable-freetype --disable-screen --disable-alsa --disable-libgcrypt
RUN make
RUN make install
