set(OPENBSW_PLATFORM posix)

if (NOT ${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    set(PLATFORM_SUPPORT_CAN
        ON
        CACHE BOOL "Turn CAN support on or off" FORCE)
    add_compile_definitions(-DPLATFORM_SUPPORT_CAN=1)

    set(PLATFORM_SUPPORT_UDS
        ON
        CACHE BOOL "Turn UDS support on or off" FORCE)
    add_compile_definitions(-DPLATFORM_SUPPORT_UDS=1)

    set(PLATFORM_SUPPORT_IO
        OFF
        CACHE BOOL "Turn IO support on or off" FORCE)
endif ()

set(PLATFORM_SUPPORT_WATCHDOG
    OFF
    CACHE BOOL "Turn OFF Watchdog support" FORCE)
set(PLATFORM_SUPPORT_MPU
    OFF
    CACHE BOOL "Turn OFF MPU support" FORCE)
