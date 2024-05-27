######################
# Wrapper macro to set boolean value to a variable
macro(setSofaOption name value)
    set(${name} "${value}" CACHE BOOL "" FORCE)
    #message("${name} ${value}")
endmacro()

macro(setSofaPath name value)
    set(${name} "${value}" CACHE PATH "" FORCE)
    #message("${name} ${value}")
endmacro()

macro(setSofaString name value)
    set(${name} "${value}" CACHE STRING "" FORCE)
    #message("${name} ${value}")
endmacro()

macro(setSofaFilePath name value)
    set(${name} "${value}" CACHE FILEPATH "" FORCE)
    #message("${name} ${value}")
endmacro()
######################

function(export_sofa_target)
    #if we are on the mimesis branch, this function must be disable since targets are exported by sofa
    #if you are in master you need to acrivate this function so that assist export targets of sofa

    install(TARGETS ${ARGV0} EXPORT ${ARGV0})
    export(EXPORT ${ARGV0} FILE "${CMAKE_BINARY_DIR}/lib/cmake/${ARGV0}Targets.cmake")

    set_target_properties(${ARGV0} PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${ASSIST_INSTALL_LIBS})
    set_target_properties(${ARGV0} PROPERTIES DEBUG_POSTFIX "")
endfunction()

#redefine cmake project() command to set the MAIN_PROJECT_NAME
macro(project)
    _project(${ARGN})

    #capture MAIN_PROJECT_NAME only if not set i.e. only the first project name
    if ("${MAIN_PROJECT_NAME}" STREQUAL "")
        set(MAIN_PROJECT_NAME "${PROJECT_NAME}" CACHE INTERNAL "")
#        set(LAST_PROJECT_LIBRARY_PATH "${CMAKE_LIBRARY_PATH}" CACHE INTERNAL "")
    else()
        set(SUB_PROJECT_NAME "${PROJECT_NAME};${SUB_PROJECT_NAME}" CACHE INTERNAL "")
    endif()
endmacro()

#function(export_sofa_plugin)
#    #if we are on the mimesis branch, this function must be disable since targets are exported by sofa
#    #if you are in master you need to acrivate this function so that assist export targets of sofa

#    if (NOT "${ARGV0}" STREQUAL "")
#        get_target_property(BUILD_TARGET ${ARGV0} INSTALL_RPATH)
#        if (NOT "${BUILD_TARGET}" STREQUAL "BUILD_TARGET-NOTFOUND")
#            if (TARGET ${ARGV0})
#                # Do something when target found
#                install(TARGETS ${ARGV0} EXPORT ${ARGV0})
#                export(EXPORT ${ARGV0} FILE "${CMAKE_BINARY_DIR}/lib/cmake/${ARGV0}Targets.cmake")
#            else()
#              message("TARGET DOES NOT EXIST ${ARGV0}")
#            endif()
#        else()
#          message("WARNING IGNORE EXPORTING TARGET ${ARGV0}")
#        endif()
#    endif()

#endfunction()

macro(add_sofa)
    #find dependencies of all ros2 modules :)

    list(APPEND CMAKE_PREFIX_PATH "${CMAKE_BINARY_DIR}/lib/cmake")

    get_plugin_path(${ARGV0} PLUGIN_PATH BUILD_PLUGIN_PATH)
    list(APPEND CMAKE_MODULE_PATH ${PLUGIN_PATH}/cmake/Modules/)

    #set MAIN_PROJECT_NAME to empty so that we capture only the first project name
    set(MAIN_PROJECT_NAME "" CACHE INTERNAL "")
    set(SUB_PROJECT_NAME "" CACHE INTERNAL "")

    add_subdirectory(${PLUGIN_PATH} ${CMAKE_BINARY_DIR}/sofa)

    list(REMOVE_ITEM SUB_PROJECT_NAME " ") # Remove empty imtem
    list(REMOVE_ITEM SUB_PROJECT_NAME "Sofa.GUI") # Remove empty imtem
    list(REMOVE_ITEM SUB_PROJECT_NAME "cxxopts") # Remove empty imtem
    
    foreach(SOFA_TARGET ${SUB_PROJECT_NAME})
        export_sofa_target(${SOFA_TARGET})
        #Disable warnings in sofa
        target_compile_options(${SOFA_TARGET} PRIVATE -w)
    endforeach()

    set(SOFA_PLUGIN_DIR "${CMAKE_BINARY_DIR}/lib" CACHE INTERNAL "")
    set(SOFA_SOURCE_DIR ${PLUGIN_PATH} CACHE INTERNAL "")

    file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/include/Sofa.Compat)
    file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/include/Sofa.Component.Compat)

    set(metis_FIND_VERSION_EXACT FALSE)
    list(APPEND CMAKE_MODULE_PATH ${PLUGIN_PATH}/Sofa/framework/Config/cmake/Modules)
endmacro()

macro(link_sofa_plugin)
    #create a sim link to make the sofa plugin a assist plugin
    add_custom_target(
        ${ARGV0}_LINK ALL
        COMMAND ${CMAKE_COMMAND} -P ${ASSIST_BINARY_DIR}/cmake-generated/create_assist_link.cmake ${ASSIST_INSTALL_LIBS}/lib${ARGV0}.so
    )

    add_dependencies(${ARGV0}_LINK ${ARGV0})
endmacro(link_sofa_plugin)

macro(add_sofa_plugin)
    get_plugin_path(${ARGV0} PLUGIN_PATH BUILD_PLUGIN_PATH)

    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/install/lib)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/install/lib)

    #set MAIN_PROJECT_NAME to empty so that we capture only the first project name
    set(MAIN_PROJECT_NAME "" CACHE INTERNAL "")
    set(SUB_PROJECT_NAME "" CACHE INTERNAL "")

    add_subdirectory(${PLUGIN_PATH} ${BUILD_PLUGIN_PATH})

    export_sofa_target(${MAIN_PROJECT_NAME})
    link_sofa_plugin(${MAIN_PROJECT_NAME})

    foreach(SOFA_TARGET ${SUB_PROJECT_NAME})
        export_sofa_target(${SOFA_TARGET})
    endforeach()
endmacro(add_sofa_plugin)

macro(add_sofa_plugin_no_target)
    get_plugin_path(${ARGV0} PLUGIN_PATH BUILD_PLUGIN_PATH)

    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/install/lib)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/install/lib)

    #set MAIN_PROJECT_NAME to empty so that we capture only the first project name
    set(MAIN_PROJECT_NAME "" CACHE INTERNAL "")
    set(SUB_PROJECT_NAME "" CACHE INTERNAL "")

    add_subdirectory(${PLUGIN_PATH} ${BUILD_PLUGIN_PATH})

    export_sofa_target(${MAIN_PROJECT_NAME})
    link_sofa_plugin(${MAIN_PROJECT_NAME})
endmacro(add_sofa_plugin_no_target)


file(GLOB SOFA_FILES  "${CMAKE_BINARY_DIR}/lib/cmake/*.cmake")
if (NOT "${SOFA_FILES}" STREQUAL "")
    file(REMOVE ${SOFA_FILES})
endif()

