module 0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::version {
    public fun migrate(arg0: &mut 0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::project_manager::ProjectManagerConfig, arg1: &mut 0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::milestone::VestingConfig, arg2: &0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::launchpad_manager_config::LaunchManagerAdmin) {
        0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::project_manager::migrate(arg0);
        0x71b3fab75c3c2869cef6e4e6023fd02330fcb0d8912bb3fe0265253cfe2e3cd3::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

