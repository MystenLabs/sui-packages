module 0xdaf6c84fa5ed9eb70f4f5acc84a2e18f056642f28282f04cb428ecacf66d7acd::version {
    public fun migrate(arg0: &mut 0xdaf6c84fa5ed9eb70f4f5acc84a2e18f056642f28282f04cb428ecacf66d7acd::project_manager::ProjectManagerConfig, arg1: &mut 0xdaf6c84fa5ed9eb70f4f5acc84a2e18f056642f28282f04cb428ecacf66d7acd::milestone::VestingConfig, arg2: &0xdaf6c84fa5ed9eb70f4f5acc84a2e18f056642f28282f04cb428ecacf66d7acd::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0xdaf6c84fa5ed9eb70f4f5acc84a2e18f056642f28282f04cb428ecacf66d7acd::launchpad_manager::LaunchpadManager) {
        0xdaf6c84fa5ed9eb70f4f5acc84a2e18f056642f28282f04cb428ecacf66d7acd::project_manager::migrate(arg0);
        0xdaf6c84fa5ed9eb70f4f5acc84a2e18f056642f28282f04cb428ecacf66d7acd::milestone::migrate(arg1);
        0xdaf6c84fa5ed9eb70f4f5acc84a2e18f056642f28282f04cb428ecacf66d7acd::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

