module 0x5e07bd5d03bb12d8813da7dd0e20bdfe1bd17666de6310dc90f7addbc5969108::version {
    public fun migrate(arg0: &mut 0x5e07bd5d03bb12d8813da7dd0e20bdfe1bd17666de6310dc90f7addbc5969108::project_manager::ProjectManagerConfig, arg1: &mut 0x5e07bd5d03bb12d8813da7dd0e20bdfe1bd17666de6310dc90f7addbc5969108::milestone::VestingConfig, arg2: &0x5e07bd5d03bb12d8813da7dd0e20bdfe1bd17666de6310dc90f7addbc5969108::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0x5e07bd5d03bb12d8813da7dd0e20bdfe1bd17666de6310dc90f7addbc5969108::launchpad_manager::LaunchpadManager) {
        0x5e07bd5d03bb12d8813da7dd0e20bdfe1bd17666de6310dc90f7addbc5969108::project_manager::migrate(arg0);
        0x5e07bd5d03bb12d8813da7dd0e20bdfe1bd17666de6310dc90f7addbc5969108::milestone::migrate(arg1);
        0x5e07bd5d03bb12d8813da7dd0e20bdfe1bd17666de6310dc90f7addbc5969108::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

