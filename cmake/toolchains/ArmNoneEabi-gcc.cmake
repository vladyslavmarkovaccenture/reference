set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

set(ARM_TARGET_TRIPLE arm-none-eabi)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

add_compile_definitions(REALTIME_OS=1)
add_compile_definitions(ESTL_NO_ASSERT_MESSAGE=1)

set(CMAKE_ASM_SOURCE_FILE_EXTENSIONS "s;S")

set(CPU_BUILD_FLAGS "-mcpu=cortex-m4 \
-mfloat-abi=hard -mfpu=fpv4-sp-d16 -fmessage-length=0")
set(C_COMMON_FLAGS
    "${CPU_BUILD_FLAGS} -mthumb -fshort-enums \
-mno-unaligned-access -Wno-psabi \
-fno-asynchronous-unwind-tables -fno-builtin -fno-common \
-ffunction-sections -fdata-sections")

set(CMAKE_ASM_FLAGS "-g -mcpu=cortex-m4")
set(CMAKE_C_FLAGS "${C_COMMON_FLAGS} -ffreestanding")
set(CMAKE_CXX_FLAGS "${C_COMMON_FLAGS} -fno-rtti -fno-exceptions \
-fno-non-call-exceptions -fno-threadsafe-statics -fno-use-cxa-atexit")
set(CMAKE_EXE_LINKER_FLAGS "${CPU_BUILD_FLAGS} -static \
-Wl,--gc-sections -Wl,-Map,application.map,--cref")

# Toolchain for gcc-arm-none-eabi-10.3-2021.10
include("${CMAKE_CURRENT_LIST_DIR}/ArmNoneEabi.cmake")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -funsigned-bitfields")
set(CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -funsigned-bitfields -femit-class-debug-always")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} \
--specs=nano.specs -specs=nosys.specs")

set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++)
set(CMAKE_ASM_COMPILER arm-none-eabi-as)
set(CMAKE_LINKER arm-none-eabi-g++)
set(CMAKE_AR arm-none-eabi-ar)

