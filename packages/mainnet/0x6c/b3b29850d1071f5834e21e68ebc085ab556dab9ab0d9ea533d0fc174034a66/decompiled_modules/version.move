module 0x6cb3b29850d1071f5834e21e68ebc085ab556dab9ab0d9ea533d0fc174034a66::version {
    public fun migrate(arg0: &mut 0x6cb3b29850d1071f5834e21e68ebc085ab556dab9ab0d9ea533d0fc174034a66::project_manager::ProjectManagerConfig, arg1: &mut 0x6cb3b29850d1071f5834e21e68ebc085ab556dab9ab0d9ea533d0fc174034a66::milestone::VestingConfig, arg2: &0x6cb3b29850d1071f5834e21e68ebc085ab556dab9ab0d9ea533d0fc174034a66::launchpad_manager_config::LaunchManagerAdmin) {
        0x6cb3b29850d1071f5834e21e68ebc085ab556dab9ab0d9ea533d0fc174034a66::project_manager::migrate(arg0);
        0x6cb3b29850d1071f5834e21e68ebc085ab556dab9ab0d9ea533d0fc174034a66::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

