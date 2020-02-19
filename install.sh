!/bash/sh

ln .* ~

sudo yum install -y vim
vim --version

// 時刻のタイムゾーンを東京
sudo timedatectl set-timezone Asia/Tokyo
sudo timedatectl set-local-rtc no
