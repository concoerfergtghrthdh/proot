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

# Create a non-root user with UID 1000
RUN useradd -u 1000 -m myuser

# Start XRDP and ngrok tunnel in CMD
CMD (start xrdp &) && (sleep 10 && ngrok tcp 3389)
