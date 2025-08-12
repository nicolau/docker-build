# Docker Setup

This guide walks you through using a Dockerfile to create and manage a Docker image and container for an R + Bioconductor environment.

---

## Dockerfile

Below is the Dockerfile used to build the image:

```dockerfile
FROM rocker/r-ver:4.5.1

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt upgrade -y

RUN apt install -y \
    vim \
    htop \
    curl \
    libcurl4-openssl-dev \
    libssl-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libfribidi-dev \
    libgdal-dev \
    libudunits2-dev \
    cmake \
    libgeos-dev \
    libproj-dev \
    libgit2-dev \
    pkgconf

RUN apt clean && rm -rf /var/lib/apt/lists/*

WORKDIR /home

RUN R -e "install.packages('BiocManager', repos='https://cloud.r-project.org')"
RUN R -e "BiocManager::install(ask = FALSE)"
RUN R -e "BiocManager::install('rhdf5', ask = FALSE)"
RUN R -e "install.packages('devtools', repos='https://cloud.r-project.org')"

# Install specific R libraries here!

CMD ["/bin/bash"]
```

---

## How to Create a Docker Image

Open a terminal in the same directory as the `Dockerfile` and run:

```bash
docker build -t IMAGE_NAME .
```

This builds the image and tags it as `IMAGE_NAME`.

---

## How to Create a Container

```bash
docker run -itd \
  --name CONTAINER_NAME \
  --platform=linux/amd64 \ # Optional
  -v /Users/YOUR_USERNAME/Documents/Docker/:/home \
  IMAGE_NAME /bin/bash
```

---

## How to Open the Container

```bash
docker exec -it CONTAINER_NAME bash
```

You’ll get an interactive shell inside the running container.

---

## How to Stop the Container

```bash
docker stop CONTAINER_NAME
```

---

## How to Delete the Container

```bash
docker rm CONTAINER_NAME
```

---

## How to Delete the Image

```bash
docker rmi IMAGE_NAME
```

---

## Notes

- Replace `/Users/YOUR_USERNAME/...` with your actual local path.
- Use `--no-cache` when building if you want to avoid using Docker’s cached layers:
  ```bash
  docker build --no-cache -t IMAGE_NAME .
  ```
