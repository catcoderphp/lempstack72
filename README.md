# lempstack72
A Docker image to NGINX PHP7.2 Mysql 5.7

# Requeriments

A docker installation. How to install [docker](https://docs.docker.com/install/ "Docker installation").

# usage
To get the image write the follow command

` docker pull catcoder/lempstack72 `

This install the image on your Docker installation

# Create a container

Once you have pulled the image, to create a container run the follow command:

` docker run -p 8081:80 --name lempstack72Container catcoder/lempstack72 `

This will run a server on your [Localhost](http://localhost:8081 "Docker installation").