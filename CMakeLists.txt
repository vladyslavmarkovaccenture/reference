cmake_minimum_required(VERSION 3.22 FATAL_ERROR)

project(
    "Eclipse OpenBSW ReferenceApp"
    DESCRIPTION
        "BSW workspace with reference application for multiple platforms"
    LANGUAGES CXX C ASM)

option(PLATFORM_SUPPORT_CAN "Turn CAN support on or off" OFF)
option(PLATFORM_SUPPORT_IO "Turn IO support on or off" OFF)
option(PLATFORM_SUPPORT_UDS "Turn UDS support on or off" OFF)

set(BUILD_TARGET_PLATFORM
    "POSIX"
    CACHE STRING "Target Platform")

# Convert target name to lower case to match directory name
string(TOLOWER "${BUILD_TARGET_PLATFORM}" OPENBSW_TARGET)
include(platforms/${OPENBSW_TARGET}/Options.cmake)

message(STATUS "Target platform: <${BUILD_TARGET_PLATFORM}>")

if (PLATFORM_SUPPORT_CAN)
    add_compile_definitions(-DPLATFORM_SUPPORT_CAN=1)
    set(PLATFORM_SUPPORT_UDS
        ON
        CACHE BOOL "Turn UDS support on or off" FORCE)
    add_compile_definitions(-DPLATFORM_SUPPORT_UDS=1)
endif ()

get_cmake_property(_all_vars VARIABLES)
foreach (var ${_all_vars})
    if (var MATCHES "^PLATFORM_SUPPORT_")
        if (${var})
            # add_compile_definitions(${var}=1)
            message(STATUS "!!!${var} ON")
        endif ()
    endif ()
endforeach ()

add_subdirectory(3rdparty/openbsw)

# Configure async and freeRtos libs depending on build type.
add_library(asyncPlatform ALIAS asyncFreeRtos)
add_library(osFreeRtos ALIAS freeRtos)

#[[
  Reference application is cross-platform, therefore options are
  target-dependent.
#]]
add_subdirectory(platforms/${OPENBSW_TARGET})

add_subdirectory(application)
add_subdirectory(asyncBinding)
add_subdirectory(asyncCoreConfiguration)
add_subdirectory(configuration)
add_subdirectory(consoleCommands)
add_subdirectory(udsConfiguration)
add_subdirectory(transportConfiguration)
