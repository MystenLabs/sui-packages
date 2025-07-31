module 0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::version {
    public fun migrate(arg0: &mut 0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::project_manager::ProjectManagerConfig, arg1: &mut 0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::milestone::VestingConfig, arg2: &0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::launchpad_manager_config::LaunchManagerAdmin) {
        0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::project_manager::migrate(arg0);
        0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

