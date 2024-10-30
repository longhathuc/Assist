**Assist: A Flexible Tool for Fast Development in Robotics and Simulation**

Assist is an advanced graphical programming software tailored to facilitate the fusion of heterogeneous data from finite element numerical simulations with essential inputs for robotic control, non-rigid registration of finite element models, and augmented reality. The software provides a platform for smooth data exchange between different processors and libraries, integrating popular libraries such as OpenCV, ROS2, SOFA, CUDA, and Python.

### Note on Build Structure

Assist is built and structured in a modular fashion, with multiple unit plugins that allow you to compile and run only the necessary components of the software. This modular design is managed using Git submodules, enabling efficient development and maintenance of each unit.

The main project repository on GitHub contains the list of submodules, whereas all the plugins are hosted on the GitLab instance of ICube. Each plugin is developed and maintained as a separate submodule, providing flexibility in compiling and running only the required pieces of code for your specific use case.

More information about the existing plugins can be found on the website: [https://assist.cnrs.fr/](https://assist.cnrs.fr/)

### Step-by-Step Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/courtecuisse/Assist.git
   cd Assist
   ```
   
2. **Initialize and Update Submodules:**:
   ```bash   
   git submodule init
   git submodule update
   ```

3. **Build and Install Assist:**:
   ```bash   
   mkdir build
   cd build
   cmake ..
   make
   sudo make install
   ```
4. **ROS Installation: **
   Follow https://docs.ros.org/en/jazzy/Installation/Ubuntu-Install-Debs.html to install ROS 2 on Ubuntu 24.04

5. **CUDA Installation: **
   
` wget https://developer.download.nvidia.com/compute/cuda/12.6.2/local_installers/cuda_12.6.2_560.35.03_linux.run
sudo sh cuda_12.6.2_560.35.03_linux.run`

6. Follow https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent to create ssh key for github and gitlab
   After get the public key, paste the key in the SSH Keys list of
   https://github.com
   https://gitlab.inria.fr/
   https://forge.icube.unistra.fr/
7. Clone these two
   `git@forge.icube.unistra.fr:sofa/mimesis/mimesiscript.git`
   `git@forge.icube.unistra.fr:sofa/mimesis/sofaconfig.git`

   
   
   
   
