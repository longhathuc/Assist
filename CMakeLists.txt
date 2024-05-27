cmake_minimum_required(VERSION 3.5)
project(assist)

include(assist.cmake)
include(git.cmake)
include(ros2.cmake)
include(sofa.cmake)
include(gpu.cmake)

set(CMAKE_MESSAGE_LOG_LEVEL "NOTICE")

set(GIT_FORCE_PULL FALSE)

#####################################
################# CORE## ############
#####################################

add_assist_plugin(extlibs/tinyxml)
add_assist_plugin(lib/assist_core)

add_assist_plugin(assist_main)
