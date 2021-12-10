# Jenkins slave with SSH, JDK 11 and Tomcat 9

## Installation

This project require [docker](https://docs.docker.com/engine/install/) for installation

### Launch project

```bash
# To build project
docker-compose up -d --build
# To enter inside container for linux
docker exec -it tomcat bash
# To enter inside container for windows
winpty docker exec -it tomcat bash
```
