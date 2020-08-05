#!/bin/bash
sudo docker build . -t ft_server
sudo docker run -it -p 80:80 -p 443:443 ft_server
