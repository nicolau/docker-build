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
    pkgconf \
    libx11-dev \
    libgmp-dev \
    libmpfr-dev

RUN apt clean && rm -rf /var/lib/apt/lists/*

WORKDIR /home

RUN R -e "install.packages('BiocManager', repos='https://cloud.r-project.org')"
RUN R -e "BiocManager::install(ask = FALSE)"
RUN R -e "BiocManager::install('rhdf5', ask = FALSE)"
RUN R -e "install.packages('devtools', repos='https://cloud.r-project.org')"
RUN R -e "BiocManager::install('imager', ask = FALSE)"
RUN R -e "devtools::install_github('AdamRahman/sdpt3r')"
RUN R -e "install.packages('rcdd', repos='https://cloud.r-project.org')"
RUN R -e "install.packages('Rmpfr', repos='https://cloud.r-project.org')"
RUN R -e "install.packages('CVXR', repos='https://cloud.r-project.org')"
RUN R -e "devtools::install_github('stla/PlaneGeometry')"
RUN R -e "install.packages('moments', repos='https://cloud.r-project.org')"
RUN R -e "install.packages(c('tidyverse', 'data.table', 'igraph', 'doParallel', 'foreach', 'MetBrewer', 'raster', 'rgl', 'rayshader', 'sf'), repos='https://cloud.r-project.org')"

# Install specific R libraries here!

CMD ["/bin/bash"]
