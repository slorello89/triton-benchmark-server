#!/bin/bash
curl https://raw.githubusercontent.com/GoogleCloudPlatform/compute-gpu-installation/main/linux/install_gpu_driver.py --output install_gpu_driver.py
sudo python3 install_gpu_driver.py
sudo apt-get update -yq && sudo apt-get install -yq \
     ca-certificates \
     curl \
     gnupg \
     lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
 "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
 $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
 sudo apt-get update -yq && sudo apt-get install -yq \
     docker-ce \
     docker-ce-cli \
     containerd.io \
     docker-compose-plugin
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
git clone https://github.com/triton-inference-server/server
cd server/docs/examples/
sh fetch_models.sh
cd ../../../ 
printf "\nresponse_cache{\n  enable:true\n}\n" >> server/docs/examples/model_repository/simple/config.pbtxt
printf "\nresponse_cache{\n  enable:true\n}\n" >> server/docs/examples/model_repository/densenet_onnx/config.pbtxt
