cmake_minimum_required(VERSION 3.5)
project(assist)

include(assist.cmake)
include(git.cmake)

#DISABLE UNECESSARY WARNINGS
set(CMAKE_MESSAGE_LOG_LEVEL "NOTICE")

# ACTIVE/DISABLE PULL AT CMAKE
# IF GIT_FORCE_PULL IS TRUE THE REPO WILL BE UPDATED AT EACH CMAKE
set(GIT_FORCE_PULL FALSE)

#####################################
#############  CORE  ################
#####################################

add_assist_plugin(extlibs/tinyxml)
add_assist_plugin(lib/assist_core)
add_assist_plugin(assist_main)

#####################################
########### LOCAL CONFIG ############
#####################################

if (EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/local_config.cmake)
    include(${CMAKE_CURRENT_SOURCE_DIR}/local_config.cmake)
endif()
