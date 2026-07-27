FROM node:20 as theme-builder

# Copy all themes into the image
COPY themes /tmp/themes

# Automatically build the themes, to ensure up-to-date assets
RUN for theme in /tmp/themes/*; do \
    if [ -f "$theme/package.json" ]; then \
    echo "Building theme: $theme"; \
    cd "$theme" && \
    npm install && \
    npm run build && \
    rm -rf node_modules; \
    else \
    echo "No build step for theme: $theme"; \
    fi; \
    done;


FROM ghcr.io/ctfd/ctfd:3.8.6 as ctfd

# Copy plugins from the repository into the image
COPY plugins /tmp/plugins

# Copy the contents of the plugin directory, if it does not contian a src directory, into the /opt/CTFd/CTFd/plugins directory
RUN for plugin in /tmp/plugins/*; do \
    if [ -d "$plugin/src" ]; then \
    echo "Copying $plugin/src to /opt/CTFd/CTFd/plugins/$(basename $plugin)"; \
    cp -r "$plugin/src" /opt/CTFd/CTFd/plugins/$(basename $plugin); \
    else \
    echo "Copying $plugin to /opt/CTFd/CTFd/plugins/$(basename $plugin)"; \
    cp -r "$plugin" /opt/CTFd/CTFd/plugins/$(basename $plugin); \
    fi; \
    done; \
    # If the plugins src directory contians a requirements.txt file, install the dependencies
    for d in /opt/CTFd/CTFd/plugins/*/; do \
    if [ -f $d/requirements.txt ]; then \
    pip install -r $d/requirements.txt; \
    fi; \
    done; 

# Copy theme
COPY --from=theme-builder /tmp/themes /opt/CTFd/CTFd/themes

# Delete line 30 of /opt/CTFd/CTFd/utils/__init__.py in order to smooth development of themes (cache of assets)
ARG DEVELOPMENT=false
RUN if [ "$DEVELOPMENT" = "true" ]; then \
    sed -i '31d' /opt/CTFd/CTFd/utils/__init__.py; \
    fi
