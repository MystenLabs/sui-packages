module 0xd7e5168d0fc05e89e552a13cedb88f410fbb7eeb70de1187578d05c83ccac8d2::version {
    public fun migrate(arg0: &mut 0xd7e5168d0fc05e89e552a13cedb88f410fbb7eeb70de1187578d05c83ccac8d2::project_manager::ProjectManagerConfig, arg1: &mut 0xd7e5168d0fc05e89e552a13cedb88f410fbb7eeb70de1187578d05c83ccac8d2::milestone::VestingConfig, arg2: &0xd7e5168d0fc05e89e552a13cedb88f410fbb7eeb70de1187578d05c83ccac8d2::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0xd7e5168d0fc05e89e552a13cedb88f410fbb7eeb70de1187578d05c83ccac8d2::launchpad_manager::LaunchpadManager) {
        0xd7e5168d0fc05e89e552a13cedb88f410fbb7eeb70de1187578d05c83ccac8d2::project_manager::migrate(arg0);
        0xd7e5168d0fc05e89e552a13cedb88f410fbb7eeb70de1187578d05c83ccac8d2::milestone::migrate(arg1);
        0xd7e5168d0fc05e89e552a13cedb88f410fbb7eeb70de1187578d05c83ccac8d2::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

