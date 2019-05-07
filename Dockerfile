FROM debian:stretch-slim

# Install prerequisites for node/php7.2 installations
RUN apt-get update && apt-get install --no-install-recommends -y \
    curl \
    gnupg2 \
    lsb-release \
    apt-transport-https \
    ca-certificates \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /usr/share/man/*

# Install node/uglifyjs
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
  && apt-get install --no-install-recommends -y nodejs \
  && npm install -g uglify-js \
  && rm -rf /usr/share/man/*

# Make php7.2 available
RUN curl -sL https://packages.sury.org/php/apt.gpg > /etc/apt/trusted.gpg.d/php.gpg \
  && echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php.list \
  && apt-get update && apt-get install --no-install-recommends -y \
    bzip2 \
    php7.2 \
    php7.2-dom \
    php7.2-gd \
    php7.2-intl \
    php7.2-mbstring \
    php7.2-sqlite3 \
    php7.2-xml \
    tar \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /usr/share/man/*

# Install web server
RUN apt-get update && apt-get install --no-install-recommends -y \
    apache2 \
    libapache2-mod-php7.2 \
    libapache2-mod-security2 \
    modsecurity-crs \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /usr/share/man/*

# Install composer and dependencies
RUN curl -sL https://getcomposer.org/installer > composer-setup.php \
  && php composer-setup.php --install-dir=/usr/bin --filename=composer \
  && rm composer-setup.php \
  && apt-get update && apt-get install --no-install-recommends -y \
    git \
    zip \
    unzip \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /usr/share/man/*

