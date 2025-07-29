module 0xd30e53459b8c2c7b98998b4a4974fe19a12061c755e34ee479da7255b302d362::version {
    public fun migrate(arg0: &mut 0xd30e53459b8c2c7b98998b4a4974fe19a12061c755e34ee479da7255b302d362::project_manager::ProjectManagerConfig, arg1: &mut 0xd30e53459b8c2c7b98998b4a4974fe19a12061c755e34ee479da7255b302d362::milestone::VestingConfig, arg2: &0xd30e53459b8c2c7b98998b4a4974fe19a12061c755e34ee479da7255b302d362::launchpad_manager_config::LaunchManagerAdmin) {
        0xd30e53459b8c2c7b98998b4a4974fe19a12061c755e34ee479da7255b302d362::project_manager::migrate(arg0);
        0xd30e53459b8c2c7b98998b4a4974fe19a12061c755e34ee479da7255b302d362::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

