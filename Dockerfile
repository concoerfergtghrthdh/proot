FROM debian:latest
RUN apt update && apt install lxde xrdp -y
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-solaris-amd64.tgz -O n.tgz
RUN tar -xvzf n.tgz
RUN ./ngrok authtoken 1yENBwSuKCKupbiORPR88ZWMrtX_6pCE7ntSQwoozQKpLBKBF
RUN echo user | sudo passwd root --stdin
CMD start xrdp & sleep 10 & ./ngrok tcp 3389
