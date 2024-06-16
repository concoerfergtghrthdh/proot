# Use Debian as the base image
FROM debian:latest

# Install LXDE and XRDP
RUN apt-get update && apt-get install -y lxde xrdp

# Install ngrok
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-solaris-amd64.tgz -O /tmp/ngrok.tgz \
    && tar -xvzf /tmp/ngrok.tgz -C /usr/local/bin \
    && chmod +x /usr/local/bin/ngrok

# Set authtoken for ngrok
RUN /usr/local/bin/ngrok authtoken 1yENBwSuKCKupbiORPR88ZWMrtX_6pCE7ntSQwoozQKpLBKBF

# Create a non-root user
RUN groupadd --gid 1000 myuser \
    && useradd --uid 1000 --gid myuser --shell /bin/bash --create-home myuser \
    && echo "myuser:user" | chpasswd

# Set up sudo for the non-root user (if needed)
RUN echo "myuser ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers.d/myuser \
    && chmod 0440 /etc/sudoers.d/myuser

# Start XRDP and ngrok tunnel in CMD
CMD (start xrdp &) && (sleep 10 && ngrok tcp 3389)
