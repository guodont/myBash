#!/usr/bin/env bash
echo "Installing Ruby"
sudo apt-get update
sudo apt-get install -y git-core curl zlib1g-dev build-essential \
                     libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 \
                     libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common
cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL
rbenv install 2.1.2
rbenv global 2.1.2
echo "Ruby Installed"
echo "gem: --no-ri --no-rdoc" > ~/.gemrc

read -p "Are you want to replace gem souces?(y/n)" -t 30 ANSWER

if [ "$ANSWER" = "y" ] ;then
	echo "Next will replace gem sources to use \"https://ruby.taobao.org\""
	gem sources --remove https://rubygems.org/
	gem sources -a https://ruby.taobao.org/
elif [ "$ANSWER" = "n" ] ;then
	echo "use rubygems sources"
else
	exit
fi

echo "Installing rails"
gem install rails 

echo "Installing MySql"

echo "--- MySQL time ---"
sudo debconf-set-selections <<< '*****!!!这里改为你设置的mysql root 密码'
sudo debconf-set-selections <<< '*****!!!同上'
sudo apt-get install mysql-server  mysql-client  libmysqlclient-dev
