module 0x43a9edf63f84c569f640e5c7ef716034ee8fd7a846add5b32a998466a397db23::version {
    public fun migrate(arg0: &mut 0x43a9edf63f84c569f640e5c7ef716034ee8fd7a846add5b32a998466a397db23::project_manager::ProjectManagerConfig, arg1: &mut 0x43a9edf63f84c569f640e5c7ef716034ee8fd7a846add5b32a998466a397db23::milestone::VestingConfig, arg2: &0x43a9edf63f84c569f640e5c7ef716034ee8fd7a846add5b32a998466a397db23::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0x43a9edf63f84c569f640e5c7ef716034ee8fd7a846add5b32a998466a397db23::launchpad_manager::LaunchpadManager) {
        0x43a9edf63f84c569f640e5c7ef716034ee8fd7a846add5b32a998466a397db23::project_manager::migrate(arg0);
        0x43a9edf63f84c569f640e5c7ef716034ee8fd7a846add5b32a998466a397db23::milestone::migrate(arg1);
        0x43a9edf63f84c569f640e5c7ef716034ee8fd7a846add5b32a998466a397db23::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

