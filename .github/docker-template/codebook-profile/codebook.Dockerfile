## docker build --build-arg JHUB_VER=4.0.2 --build-arg PY_VER=3.10 --build-arg DEPLOY_KEY=wt-ephys-no-curation-deploy.pem --build-arg REPO_OWNER=dj-sciops --build-arg REPO_NAME=wt-ephys-no-curation -f codebook.Dockerfile -t registry.vathes.com/sciops/codebook-wt-ephys-no-curation:v0.0.0 .

## Single Stage
ARG JHUB_VER
ARG PY_VER
ARG DIST
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

