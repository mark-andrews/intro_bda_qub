FROM xmjandrews/hellobinder_rstan:foo
LABEL maintainer='Mark Andrews'
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}
