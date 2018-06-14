#! /usr/bin/env /bin/sh
git config --global http.proxy $proxy
git clone https://github.com/$PAGES_REPO_NWO /var/www/site
cd /var/www/site || exit
touch Gemfile
grep "source 'https://rubygems.org'" Gemfile || \
    echo "source 'https://rubygems.org'" | tee -a Gemfile
grep "gem 'github-pages', group: :jekyll_plugins" Gemfile || \
    echo "gem 'github-pages', group: :jekyll_plugins" | tee -a Gemfile
grep "gem '$theme', group: :jekyll_plugins" Gemfile || \
    echo "gem '$theme', group: :jekyll_plugins" | tee -a Gemfile
bundle install
bundle exec jekyll serve --port 8090 --host 0.0.0.0
