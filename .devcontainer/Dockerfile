FROM mcr.microsoft.com/devcontainers/python:0-3.9-bullseye

# change this for every release
ARG _AVD_VERSION
ARG _CLAB_VERSION
ARG _RELEASE_DATE
ARG _YQ_VERSION
ARG _YQ_BINARY
ARG _ARTOKEN
ARG _AR_FILE_PATH

# install some basic tools inside the container
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    sshpass \
    curl \
    iputils-ping \
    htop \
    tcpdump \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

# install yq
RUN wget https://github.com/mikefarah/yq/releases/download/${_YQ_VERSION}/${_YQ_BINARY} -O /usr/bin/yq \
    && chmod +x /usr/bin/yq

# switch user to vscode otherwise Ansible will be installed as root
USER vscode
ENV PATH=$PATH:/home/vscode/.local/bin
# # install Ansible AVD collection
# RUN pip3 install "ansible-core>=2.13.1,<2.14.0" \
#     && ansible-galaxy collection install arista.avd:==${_AVD_VERSION} \
#     && pip3 install -r /home/vscode/.ansible/collections/ansible_collections/arista/avd/requirements.txt

# install the latest containerlab and yamllint
RUN bash -c "$(curl -sL https://get.containerlab.dev)" -- -v ${_CLAB_VERSION} \
    && pip3 install --user yamllint

# add ceos-lab image is _ARTOKEN is not empty
RUN if [ ! -z ${_ARTOKEN} ]; \
    then \
    ARTOKEN=$(echo -n "${_ARTOKEN}" | base64) \
    && ARSESSION=$(curl -X "POST" "https://www.arista.com/custom_data/api/cvp/getSessionCode/" -H 'Content-Type: application/json'   -d "{\"accessToken\": \"$ARTOKEN\"}" | sed -n 's|.*"session_code":"\([^"]*\)".*|\1|p') \
    && FILE_PATH=${_AR_FILE_PATH} \
    && DOWNLOAD_URL=$(curl -X "POST" "https://www.arista.com/custom_data/api/cvp/getDownloadLink/" -H 'Content-Type: application/json' -d "{\"sessionCode\": \"$ARSESSION\", \"filePath\": \"$FILE_PATH\"}" | sed -n 's|.*"url":"\([^"]*\)".*|\1|p') \
    && mkdir -p /home/vscode/tmp \
    && curl "$DOWNLOAD_URL" --output /home/vscode/tmp/ceos-lab-temp \
    ; fi
