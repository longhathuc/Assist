**Assist: A Flexible Tool for Fast Development in Robotics and Simulation**
 
Assist is an advanced graphical programming software tailored to facilitate the fusion of heterogeneous data from finite element numerical simulations with essential inputs for robotic control, non-rigid registration of finite element models, and augmented reality. The software provides a platform for smooth data exchange between different processors and libraries, integrating popular libraries such as OpenCV, ROS2, SOFA, CUDA, and Python.

### Note on Build Structure

Assist is built and structured in a modular fashion, with multiple unit plugins that allow you to compile and run only the necessary components of the software. This modular design is managed using Git submodules, enabling efficient development and maintenance of each unit.

The main project repository on GitHub contains the list of submodules, whereas all the plugins are hosted on the GitLab instance of ICube. Each plugin is developed and maintained as a separate submodule, providing flexibility in compiling and running only the required pieces of code for your specific use case.

More information about the existing plugins can be found on the website: [https://assist.cnrs.fr/](https://assist.cnrs.fr/)

### Step-by-Step Installation

1. Having credentials with forge.icube.fr and gitlab.inria.fr
   
2. **ROS Installation: **
   Follow https://docs.ros.org/en/jazzy/Installation/Ubuntu-Install-Debs.html to install ROS 2 on Ubuntu 24.04
   Install colcon to build ros related projects
   <pre><code>sudo apt install python3-colcon-common-extensions</code></pre>
3. **CUDA Installation: **
<pre><code>    
wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_520.61.05_linux.run
chmod +x cuda_11.8.0_520.61.05_linux.run
sudo ./cuda_11.8.0_520.61.05_linux.run
</code></pre>
For cuda 12
wget https://developer.download.nvidia.com/compute/cuda/12.6.0/local_installers/cuda_12.6.0_560.28.03_linux.run

If you choose cuda 11 privilege the g++ 11 to compile. Set priority to 100 will make it default

<pre><code>sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 100</code></pre>

4. Follow https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent to create ssh key for github and gitlab
   After get the public key, paste the key in the SSH Keys list of
   https://github.com
   https://gitlab.inria.fr/
   https://forge.icube.unistra.fr/
   
5. Clone these two repositories 
   <pre><code> 
   git@forge.icube.unistra.fr:sofa/mimesis/mimesiscript.git
   git@forge.icube.unistra.fr:sofa/mimesis/sofaconfig.git
   </code></pre>

6. Run the follow in line in terminal to get the Sources code
   <pre><code>sofascript ua</code></pre>
7. Add these lines to .bashrc in home folder
<pre><code> 
PATH=$PATH:/home/yourname/work/Sources/forge.icube.unistra.fr/sofa/mimesis/mimesiscript:/home/yourname/work/Sources/forge.icube.unistra.fr/assist/assist_config
export CUDA_HOME=/usr/local/cuda-cudaversion
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-cudaversion/lib64:/usr/local/cuda-cudaversion/extras/CUPTI/lib64
export PATH=$PATH:$CUDA_HOME/bin


SOFA_INSTALL_DIR=/home/yourname/work/build/sofaAssistBuild/lib/cmake
SOFA_WORK_DIRECTORY=/home/yourname/work/Sources
SOFA_CONFIG_DIRECTORY=/home/yourname/work/Sources/forge.icube.unistra.fr/sofa/mimesis/sofaconfig/yourconfigname

export SOFA_WORK_DIRECTORY
export SOFA_CONFIG_DIRECTORY
export SOFA_INSTALL_DIR

export PATH=$PATH:/home/yourname/work/build/sofaAssistBuild/bin:/home/yourname/work/build/sofaAssistBuild/install/bin
export CMAKE_MODULE_PATH=$CMAKE_MODULE_PATH:/home/yourname/work/build/sofaAssistBuild/assist/cmake


#ROS2
source /opt/ros/jazzy/setup.bash
source /home/yourname/work/build/sofaAssistBuild/assist/install/setup.bash


export ROS_DOMAIN_ID=yourDomainIDByChoice

export PYTHONPATH=$PYTHONPATH:/home/yourname/work/build/sofaAssistBuild/install/lib
</code></pre>

8. create your CMakeLists.txt in assist_config
   sample file can be found in

   <pre><code>forge.icube.unistra.fr/assist/assist_config/long_ros2</code></pre>
10. Use Qt Creator to configure and build the project in to  /home/yourname/work/build/sofaAssistBuild
   
11. Run the following code to test 
<pre><code>
    assist_gui /home/yourusername/work/Sources/forge.icube.unistra.fr/sofa/sperry/scenes/Demos/Full-Simu/SharedControl_FIX_IIWA/ICRA2025/Inverse_Human_Auto.flow

assist_fork /home/yourusername/work/Sources/forge.icube.unistra.fr/sofa/sperry/scenes/Demos/Full-Simu/SharedControl_FIX_IIWA/ICRA.fork
</code></pre>

   
