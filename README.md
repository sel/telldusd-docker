# Dockerfile for telldusd

Dockerfile for containerising the telldus daemon, suitable for running on a Raspberry Pi.

Includes a work-around for the libconfuse dependency problem based on
[this](https://antonneld.wordpress.com/2018/04/21/setting-up-a-tellstick-duo-on-linux-in-2018/)
blog post.

The default [tellstick.conf](tellstick.conf) supplied here needs to be modified for your setup.

Refer to [telldus](https://github.com/telldus/telldus) regarding the daemon itself.

The container image, built for the Raspberry Pi armhf ABI, is available on
[Docker Hub](https://hub.docker.com/r/slarkin/telldusd-docker/)
