# Use miniconda3 base image
FROM continuumio/miniconda3
#FROM rocker/r-ver:4.3.1

# Non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Update system and install required libraries including R

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
        libproj-dev

RUN apt install -y r-base

RUN apt clean

RUN rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /home

RUN R -e "install.packages('BiocManager', repos='https://cloud.r-project.org')"
RUN R -e "BiocManager::install(ask = FALSE)"
RUN R -e "BiocManager::install('rhdf5', ask = FALSE)"
RUN R -e "install.packages('devtools', repos='https://cloud.r-project.org')"

# Clone the GitHub repo to /opt
## RUN git clone git@github.com:csbl-br/archipelaGO.git /opt/ArchipelaGO

# Install the R package from the cloned repo
## RUN R -e "devtools::install('/opt/ArchipelaGO', upgrade = 'never')"

# Default command
CMD ["/bin/bash"]
