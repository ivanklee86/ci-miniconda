FROM ubuntu:latest
LABEL MAINTAINER="Ivan <aoach.public@gmail.com>"

# From https://repo.continuum.io/miniconda/
ARG miniconda_md5="7fe70b214bee1143e3e3f0467b71453c"

# Set up container information
WORKDIR /root

# Install support packages.
RUN apt-get update \
 && apt-get install -y curl python-dev sudo bzip2 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists /var/cache/apt

# Download miniconda, verify MD5 hash, install for all users, and remove temporary files.
COPY check_md5.sh check_md5.sh
RUN curl -LO http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
 && chmod 755 Miniconda3-latest-Linux-x86_64.sh \
 && ./check_md5.sh Miniconda3-latest-Linux-x86_64.sh ${miniconda_md5} \
 && ./Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
 && rm -rf Miniconda3-latest-Linux-x86_64.sh \
 && rm -rf check_md5.sh

 # Add miniconda to PATH.
ENV PATH /opt/conda/bin:$PATH

# Update conda and install latest maintainance release.
RUN conda update -y conda
RUN conda install -y python=3.6.3

# Install twine so you can upload package to pypi!
RUN pip install twine

CMD ["/bin/bash"]