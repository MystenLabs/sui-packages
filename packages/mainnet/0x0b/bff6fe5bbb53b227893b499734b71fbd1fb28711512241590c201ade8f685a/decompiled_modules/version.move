module 0xbbff6fe5bbb53b227893b499734b71fbd1fb28711512241590c201ade8f685a::version {
    public fun migrate(arg0: &mut 0xbbff6fe5bbb53b227893b499734b71fbd1fb28711512241590c201ade8f685a::project_manager::ProjectManagerConfig, arg1: &mut 0xbbff6fe5bbb53b227893b499734b71fbd1fb28711512241590c201ade8f685a::milestone::VestingConfig, arg2: &0xbbff6fe5bbb53b227893b499734b71fbd1fb28711512241590c201ade8f685a::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0xbbff6fe5bbb53b227893b499734b71fbd1fb28711512241590c201ade8f685a::launchpad_manager::LaunchpadManager) {
        0xbbff6fe5bbb53b227893b499734b71fbd1fb28711512241590c201ade8f685a::project_manager::migrate(arg0);
        0xbbff6fe5bbb53b227893b499734b71fbd1fb28711512241590c201ade8f685a::milestone::migrate(arg1);
        0xbbff6fe5bbb53b227893b499734b71fbd1fb28711512241590c201ade8f685a::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

