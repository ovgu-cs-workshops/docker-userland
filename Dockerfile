# syntax = edrevo/dockerfile-plus
INCLUDE+ go-k8s-userland/Dockerfile

FROM docker:20.10-dind-rootless

ENV DOCKER_HOST="unix:///run/user/1000/docker.sock"

USER root

RUN set -ex \
    && apk add --no-cache \
        k9s \
        jq \
        bash \
        zsh \
        tmux \
        nano \
        vim \
        emacs-nox \
        less \
        libuser \
    && apk add --no-cache curl git terraform \
    && su rootless -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"' \
    && sed -i s/robbyrussell/gianu/g /home/rootless/.zshrc \
    && curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash \
    && curl -sSfL "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && apk del curl git \
    && touch /etc/login.defs \
    && mkdir /etc/default \
    && touch /etc/default/useradd \
    && echo "auth sufficient pam_shells.so" > /etc/pam.d/chsh \
    && echo "$(which zsh)" | lchsh rootless

COPY start-userland.sh /usr/local/bin/
COPY run-shell.sh /usr/local/bin/

COPY --from=builder /bin/git-userland /bin/git-userland

USER rootless

ENTRYPOINT ["start-userland.sh"]
