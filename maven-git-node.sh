# @Author: guodong
# @Date:   2020-03-15 09:30
# @Last Modified by:   guodong
# @Last Modified time: 2020-03-15 09:30
 
#!/bin/bash
SOFT_PATH=/opt/soft
 
if [ ! -d $SOFT_PATH ];then
mkdir $SOFT_PATH
else
echo "文件夹已经存在"
fi
 
yum install -y wget 
 
#install node11.0
cd $SOFT_PATH
wget https://npm.taobao.org/mirrors/node/v11.0.0/node-v11.0.0.tar.gz
tar -xvf node-v11.0.0.tar.gz
cd node-v11.0.0
yum -y install gcc gcc-c++
./configure
make
make install
NODE_HOME=`pwd`

#install maven3.2.3
cd $SOFT_PATH
wget https://archive.apache.org/dist/maven/maven-3/3.2.3/binaries/apache-maven-3.2.3-bin.tar.gz
tar -zxvf apache-maven-3.2.3-bin.tar.gz -C $SOFT_PATH
mv apache-maven-3.2.3 maven-3.2.3
cd maven*
MAVEN_HOME=`pwd`
 
#install git 2.8.0
cd $SOFT_PATH
yum -y install zlib-devel openssl-devel cpio expat-devel gettext-devel curl-devel perl-ExtUtils-CBuilder perl-ExtUtils- MakeMaker
wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.8.0.tar.gz
tar -zxvf git-2.8.0.tar.gz -C $SOFT_PATH
cd git*
./configure
make install
ln -s /usr/local/bin/git /usr/bin/git
 
#追加环境变量
echo "export NODE_HOME=${NODE_HOME}" >> /etc/profile
echo "export PATH=$""NODE_HOME/bin:$""PATH" >> /etc/profile
echo "export MAVEN_HOME=${MAVEN_HOME}" >> /etc/profile
echo "export PATH=$""MAVEN_HOME/bin:$""PATH" >> /etc/profile
source /etc/profile
#输出信息
echo "-----source update-----"
echo "node version"
node -v
echo "maven version"
mvn -v
echo "-----path-----"
echo "NODE_HOME:"$NODE_HOME
echo "MAVEN_HOME:"$MAVEN_HOME
