 # Use Debian as the base image
FROM debian:latest

# Install LXDE and XRDP
RUN apt-get update && apt-get install -y wmaker xrdp

# Install ngrok
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com/ buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok
# Set authtoken for ngrok
RUN ngrok authtoken 1yENBwSuKCKupbiORPR88ZWMrtX_6pCE7ntSQwoozQKpLBKBF

# Create a non-root user with UID 10001 and password 'user'
RUN groupadd --gid 10001 myuser && useradd --uid 10001 --gid myuser --shell /bin/bash --create-home myuser && echo "myuser:user" | chpasswd

# Set up sudo for the non-root user (if needed)
RUN echo "myuser ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers.d/myuser && chmod 0440 /etc/sudoers.d/myuser

# Set USER to 10001
USER 10001

# Start XRDP and ngrok tunnel in CMD
CMD (start xrdp &) && (sleep 10 && ngrok tcp 3389)
