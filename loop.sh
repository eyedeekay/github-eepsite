#! /usr/bin/env /bin/sh
gem install --user-install jekyll jekyll-theme-minimal github-pages kramdown jekyll-feed bundler
git config --global http.proxy $proxy
mkdir -p /var/www/site && cd /var/www/site
git clone https://github.com/$PAGES_REPO_NWO .
touch Gemfile
grep "source 'https://rubygems.org'" Gemfile || \
    echo "source 'https://rubygems.org'" | tee -a Gemfile
grep "gem 'github-pages', group: :jekyll_plugins" Gemfile || \
    echo "gem 'github-pages', group: :jekyll_plugins" | tee -a Gemfile
bundle install
bundle exec jekyll serve --port 8090 --host 0.0.0.0
