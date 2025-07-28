module 0xd938eca5b9dc7f453111303e1a1db4928fd73ba858e41c4376d5d5d70eb33a8a::version {
    public fun migrate(arg0: &mut 0xd938eca5b9dc7f453111303e1a1db4928fd73ba858e41c4376d5d5d70eb33a8a::project_manager::ProjectManagerConfig, arg1: &mut 0xd938eca5b9dc7f453111303e1a1db4928fd73ba858e41c4376d5d5d70eb33a8a::milestone::VestingConfig, arg2: &0xd938eca5b9dc7f453111303e1a1db4928fd73ba858e41c4376d5d5d70eb33a8a::launchpad_manager_config::LaunchManagerAdmin) {
        0xd938eca5b9dc7f453111303e1a1db4928fd73ba858e41c4376d5d5d70eb33a8a::project_manager::migrate(arg0);
        0xd938eca5b9dc7f453111303e1a1db4928fd73ba858e41c4376d5d5d70eb33a8a::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

