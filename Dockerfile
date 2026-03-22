FROM node:20

ENV TZ=Asia/Tokyo

# Firewall tools + utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo curl jq git iptables ipset iproute2 dnsutils aggregate ca-certificates \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Allow 'node' user to write to npm global directory
RUN mkdir -p /usr/local/share/npm-global && chown -R node:node /usr/local/share

RUN mkdir -p /home/node/.claude && chown node:node /home/node/.claude

WORKDIR /target

USER node

ENV NPM_CONFIG_PREFIX=/usr/local/share/npm-global
ENV PATH=$PATH:/usr/local/share/npm-global/bin

RUN npm install -g @anthropic-ai/claude-code

# Download official Anthropic devcontainer firewall script and set up permissions
USER root
RUN curl -fsSL https://raw.githubusercontent.com/anthropics/claude-code/main/.devcontainer/init-firewall.sh \
    -o /usr/local/bin/init-firewall.sh

COPY --chown=node:node entrypoint.sh /usr/local/bin/entrypoint.sh
COPY --chown=node:node add-custom-domains.sh /usr/local/bin/add-custom-domains.sh

RUN chmod +x /usr/local/bin/init-firewall.sh /usr/local/bin/entrypoint.sh /usr/local/bin/add-custom-domains.sh && \
    echo "node ALL=(root) NOPASSWD: SETENV: /usr/local/bin/init-firewall.sh, /usr/local/bin/add-custom-domains.sh" \
      > /etc/sudoers.d/node-firewall && \
    chmod 0440 /etc/sudoers.d/node-firewall

USER node

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
