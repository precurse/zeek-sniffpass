#!/bin/bash
# Install Zeek
echo 'deb http://download.opensuse.org/repositories/security:/zeek/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/security:zeek.list
curl -fsSL https://download.opensuse.org/repositories/security:zeek/xUbuntu_20.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/security_zeek.gpg > /dev/null
sudo apt-get update -q
sudo apt-get install -y zeek python3-git

# Test package install
yes Y | sudo /opt/zeek/bin/zkg install .

# Test log parsing
/opt/zeek/bin/zeek -Cr tests/http_post.trace -b scripts/main.bro
grep -E "username[1-4]" http.log |wc -l |grep -q 4
grep -E "username[1-4]" notice.log |wc -l |grep -q 4
