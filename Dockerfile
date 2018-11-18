FROM debian:stretch-slim

LABEL version="1.0"
LABEL description="Containerised telldus daemon suitable for running on a Raspberry Pi"
LABEL maintainer="steve@sel.sh"

RUN apt-get update && apt-get upgrade -y

RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates \
      gnupg \
      wget

RUN echo "deb http://download.telldus.com/debian/ stable main" > /etc/apt/sources.list.d/telldus.list && \
    wget -q http://download.telldus.com/debian/telldus-public.key -O- | apt-key add -

RUN apt-get update && apt-get install -y --no-install-recommends \
      libconfuse-common \
      libconfuse1 \
      libftdi1 \
      libtelldus-core2

RUN apt-get download telldus-core && \
    dpkg --ignore-depends=libconfuse0 -i telldus-core_2.1.2-1_armhf.deb && \
    sed -i 's/\(Depends:.*\)libconfuse0[^,]*/\1libconfuse1 (>= 3.0)/' /var/lib/dpkg/status && \
    ln -s /usr/lib/arm-linux-gnueabihf/libconfuse.so.1 /usr/lib/arm-linux-gnueabihf/libconfuse.so.0 && \
    apt-get --fix-broken install -y

ENTRYPOINT ["/usr/sbin/telldusd", "--nodaemon"]
