Assist: A Flexible Tool for Fast Development in Robotics and Simulation

Assist is an advanced graphical programming software tailored to facilitate the fusion of heterogeneous data from finite element numerical simulations with essential inputs for robotic control, non-rigid registration of finite element models, and augmented reality. The software provides a platform for smooth data exchange between different processors and libraries, integrating popular libraries such as OpenCV, ROS2, SOFA, CUDA, and Python.


https://assist.cnrs.fr/


### Step-by-Step Installation


Note on Build Structure

Assist is built and structured in a modular fashion, with multiple unit plugins that allow you to compile and run only the necessary components of the software. This modular design is managed using Git submodules, enabling efficient development and maintenance of each unit.


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
