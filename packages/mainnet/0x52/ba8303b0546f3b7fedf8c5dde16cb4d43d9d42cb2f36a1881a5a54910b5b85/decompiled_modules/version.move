module 0x52ba8303b0546f3b7fedf8c5dde16cb4d43d9d42cb2f36a1881a5a54910b5b85::version {
    public fun migrate(arg0: &mut 0x52ba8303b0546f3b7fedf8c5dde16cb4d43d9d42cb2f36a1881a5a54910b5b85::project_manager::ProjectManagerConfig, arg1: &mut 0x52ba8303b0546f3b7fedf8c5dde16cb4d43d9d42cb2f36a1881a5a54910b5b85::milestone::VestingConfig, arg2: &0x52ba8303b0546f3b7fedf8c5dde16cb4d43d9d42cb2f36a1881a5a54910b5b85::launchpad_manager_config::LaunchManagerAdmin) {
        0x52ba8303b0546f3b7fedf8c5dde16cb4d43d9d42cb2f36a1881a5a54910b5b85::project_manager::migrate(arg0);
        0x52ba8303b0546f3b7fedf8c5dde16cb4d43d9d42cb2f36a1881a5a54910b5b85::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

