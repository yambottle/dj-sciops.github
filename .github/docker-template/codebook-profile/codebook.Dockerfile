ARG JHUB_VER
ARG PY_VER
FROM datajoint/djlabhub:singleuser-${JHUB_VER}-py${PY_VER}

ARG DEPLOY_KEY
COPY --chown=jovyan $DEPLOY_KEY $HOME/.ssh/id_ed25519
RUN chmod 400 $HOME/.ssh/id_ed25519 

ARG REPO_OWNER
ARG REPO_NAME
WORKDIR /home/jovyan
RUN ssh-keyscan -t ed25519 github.com >> $HOME/.ssh/known_hosts && \
    git clone git@github.com:${REPO_OWNER}/${REPO_NAME}.git && \
    pip install ./${REPO_NAME} && \
    rm -rf $HOME/.ssh/

