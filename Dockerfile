FROM ubuntu:latest
LABEL MAINTAINER="Ivan <aoach.public@gmail.com>"


# Install 64-bit packages (mainly to support Ruby & Fastlane)
RUN apt-get update \
 && apt-get install -y curl python-dev sudo bzip2 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists /var/cache/apt
 
# = Set up Jenkins user & home directory =
ARG user=jenkins
ARG group=jenkins
ARG uid=500
ARG gid=500
ARG JENKINS_HOME=/home/${user}

ENV JENKINS_HOME ${JENKINS_HOME}

RUN groupadd -g ${gid} ${group} \
    && useradd -d "${JENKINS_HOME}" -u "${uid}" -g "${gid}" -m -s /bin/bash "${user}"

USER jenkins
WORKDIR "${JENKINS_HOME}"

# Install miniconda to /miniconda
RUN curl -LO http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh \
 && bash "${JENKINS_HOME}/Miniconda-latest-Linux-x86_64.sh" -p "${JENKINS_HOME}/miniconda" -b \
 && rm Miniconda-latest-Linux-x86_64.sh

#Set environment
ENV PATH="${JENKINS_HOME}/miniconda/bin:${JENKINS_HOME}/gradle/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${PATH}"
RUN echo "export PATH=${JENKINS_HOME}/miniconda/bin:${JENKINS_HOME}/gradle/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:$PATH" >> .bashrc

# Update conda and install bundle
RUN conda update -y conda
RUN conda create --yes -n py3 python=3

CMD ["python"]