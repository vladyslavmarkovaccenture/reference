set(app.referenceExtraSources)

if (PLATFORM_SUPPORT_UDS)
    list(
        APPEND
        app.referenceExtraSources
        src/systems/TransportSystem.cpp
        src/systems/UdsSystem.cpp
        src/uds/ReadIdentifierPot.cpp)

    if (PLATFORM_SUPPORT_CAN)
        list(APPEND app.referenceExtraSources src/systems/DoCanSystem.cpp)
    endif ()
endif ()

add_executable(
    app.reference
    src/app/app.cpp
    src/app/CanDemoListener.cpp
    src/logger/logger.cpp
    src/console/console.cpp
    src/systems/DemoSystem.cpp
    src/systems/RuntimeSystem.cpp
    src/systems/SysAdminSystem.cpp
    src/systems/SafetySystem.cpp
    ${app.referenceExtraSources}
    src/main.cpp)

set_target_properties(app.reference PROPERTIES SUFFIX ".elf")

if (TARGET startUp)
    get_target_property(LINKER_SCRIPT startUp PROP_LINKER_SCRIPT)

    if (DEFINED LINKER_SCRIPT)
        target_link_options(app.reference PRIVATE -T ${LINKER_SCRIPT})
    endif ()
endif ()

target_include_directories(app.reference PRIVATE include)

target_link_libraries(
    app.reference
    PRIVATE asyncBinding
            asyncConsole
            bspMcu
            configuration
            estd
            lifecycle
            consoleCommands
            logger
            loggerIntegration
            main
            stdioConsoleInput
            osFreeRtos
            asyncFreeRtosImpl
            util
            udsConfigurationImpl
            runtime
            safeLifecycle
            socBsp)

if (PLATFORM_SUPPORT_UDS)

    target_link_libraries(app.reference PRIVATE transport
                                                   transportRouterSimple uds)

endif ()

if (PLATFORM_SUPPORT_CAN)

    target_link_libraries(app.reference PRIVATE cpp2can docan)
endif ()
