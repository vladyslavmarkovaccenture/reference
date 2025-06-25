set(OPENBSW_PLATFORM s32k1xx)

set(PLATFORM_SUPPORT_IO
    ON
    CACHE BOOL "Turn IO support on or off" FORCE)
add_compile_definitions(-DPLATFORM_SUPPORT_IO=1)
set(PLATFORM_SUPPORT_CAN
    ON
    CACHE BOOL "Turn CAN support on or off" FORCE)
add_compile_definitions(-DPLATFORM_SUPPORT_CAN=1)
set(PLATFORM_SUPPORT_WATCHDOG
    ON
    CACHE BOOL "Turn ON Watchdog support" FORCE)
add_compile_definitions(-DPLATFORM_SUPPORT_WATCHDOG=1)
set(PLATFORM_SUPPORT_MPU
    ON
    CACHE BOOL "Turn ON MPU support" FORCE)
add_compile_definitions(-DPLATFORM_SUPPORT_MPU=1)
