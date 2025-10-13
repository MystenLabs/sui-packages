module 0x2ae82cd9d13c337b8e7ba2c2a8ec956c7bc9495463f8e4a9588b29e56ad98438::version {
    public fun migrate(arg0: &mut 0x2ae82cd9d13c337b8e7ba2c2a8ec956c7bc9495463f8e4a9588b29e56ad98438::project_manager::ProjectManagerConfig, arg1: &mut 0x2ae82cd9d13c337b8e7ba2c2a8ec956c7bc9495463f8e4a9588b29e56ad98438::milestone::VestingConfig, arg2: &0x2ae82cd9d13c337b8e7ba2c2a8ec956c7bc9495463f8e4a9588b29e56ad98438::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0x2ae82cd9d13c337b8e7ba2c2a8ec956c7bc9495463f8e4a9588b29e56ad98438::launchpad_manager::LaunchpadManager) {
        0x2ae82cd9d13c337b8e7ba2c2a8ec956c7bc9495463f8e4a9588b29e56ad98438::project_manager::migrate(arg0);
        0x2ae82cd9d13c337b8e7ba2c2a8ec956c7bc9495463f8e4a9588b29e56ad98438::milestone::migrate(arg1);
        0x2ae82cd9d13c337b8e7ba2c2a8ec956c7bc9495463f8e4a9588b29e56ad98438::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

