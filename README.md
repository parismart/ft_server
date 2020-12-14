# ft_server

![logo](https://upload.wikimedia.org/wikipedia/commons/7/79/Docker_%28container_engine%29_logo.png)

> The project consists of install a complete web server. School project done at 42Madrid.

### Learn Build Teach 🚀

> As I get better, you get better! As I learn, you learn!

---

### Index 📋
You're sections headers will be used to reference location of destination.

- [Description](#description)
	- [Components 🛠️](#components)
  - [Technologies](#technologies)
- [How To Use](#how-to-use)
	- [Installation 🔧](#installation)
	- [Usage 📦](#usage)
- [References 📌](#references)
- [License 📄](#license)
- [Author Info  ✒️](#author-info)

---

## Description

This statement is intended to introduce you to basic system and network administration. 
It will allow you to install a complete web server, thanks to a deployment technology called Docker.

### Components

- ```Nginx```: Is an HTTP and reverse proxy server, a mail proxy server, and a generic TCP/UDP proxy server.

- ```MariaDB```: Is a database management system derived from MySQL with a GPL (General Public License).

- ```Wordpress```: Is a CMS(Content Managament System) focused on the creation of any type of web page.

- ```phpMyAdmin```: Is a free software tool intended to handle the administration of MySQL over the web.


### Technologies

- ```Docker```: Is a open-source project that automates the deployment of applications within software containers.


[Back To The Top](#ft_server)

---

## How To Use

### Installation

> Step 1: Update System and Install Required Packages

```shell
# Before installing any software, you need to update and upgrade the system you are working on.
sudo apt-get update -y
sudo apt-get upgrade -y
# Also, make sure to install (or check whether you already have) the following required packages:
sudo apt-get install curl
sudo apt-get install apt-transport-https
sudo apt-get install ca-certificates
sudo apt-get install software-properties-common
```

> Step 2: Install Docker

```shell
# First add the GPG key for the official Docker repository to your system.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Add the Docker repository to APT sources.
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
# Next, update the package database with the Docker packages from the newly added repo.
sudo apt update
# Make sure you are about to install from the Docker repo instead of the default Ubuntu repo.
apt-cache policy docker-cesudo
# Finally, install Docker.
sudo apt-get install docker-ce
# Docker should now be installed, the daemon started, and the process enabled to start on boot.
# Check that it’s running.
sudo systemctl status docker
# To avoid typing sudo whenever you run the docker command, add your username to the docker group:
sudo usermod -aG docker $(whoami);
# To apply the new group membership, log out of the server and back in, or type the following.
su - ${USER}
# You will be prompted to enter your user’s password to continue.
# Confirm that your user is now added to the docker group by typing.
id -nG
# Using docker consists of passing it a chain of options and commands followed by arguments.
docker [option] [command] [arguments]
# To view all available subcommands, type:
docker
```

### Usage

> Deployment

```shell
# Download
git clone https://github.com/parismart/ft_server.git
cd ft_server
# Create image
docker build . -t ft_server
# Launch container
docker run -it -p 80:80 -p 443:443 --name ft_server ft_server bash
```

[Back To The Top](#ft_server)

---

## References

[Back To The Top](#ft_server)

---

## License

MIT License

Copyright [2020] [Paris Martínez Ruiz]

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[Back To The Top](#ft_server)

---

## Author Info

- Twitter - [@TroyaParisde](https://twitter.com/TroyaParisde)
- Instagram - [@parisdetroya42](https://instagram.com/parisdetroya42)
- 42 Madrid - [parmarti](https://profile.intra.42.fr/users/parmarti)

[Back To The Top](#ft_server)
