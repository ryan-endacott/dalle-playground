# Install prereqs necessary to run dalle-playground on lambda labs instance.
# Ideally this would be a docker setup, but the docker setup requires prereq that
# failed to install on lambda labs anyways. So far, can only get it to run w/o docker.

# Notes:
# Uses CUDA 11.1 - returned from `nvcc --version`

cd backend

# If only these were the only reqs lol.
pip install -r requirements.txt

# Install CUDNN (Cuda)
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
sudo apt-get update
sudo apt-get install libcudnn8
sudo apt-get install libcudnn8-dev

# Install pytorch and its dependencies.
pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/

# https://deeptalk.lambdalabs.com/t/lambda-stack-cudnn-8-upgrade-query/1966/8
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/ubuntu/.local/lib/python3.8/site-packages/torch

# Finish with the extra pip installs not listed in requirements.txt.
# Not broken version of Jax.
pip install -Iv jax===0.3.10

# Jax extra install instructions.
pip install "jax[cuda11_cudnn805]" -f https://storage.googleapis.com/jax-releases/jax_releases.html

# Ipywidgets and jupyter.
pip install ipywidgets jupyter

# Install prereqs to run frontend.
cd ../interface
sudo apt-get install npm
npm install