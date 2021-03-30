Before you run the prereqs.sh script you need to set up a new user with administrative privlidges.
To do this just run the following commands one at a time:

sudo adduser cardanode

sudo usermod -aG sudo cardanode

sudo su - cardanode

whoami

sudo whoami


The response of whoami and sudo whoami should be cardanode & root respectively.
