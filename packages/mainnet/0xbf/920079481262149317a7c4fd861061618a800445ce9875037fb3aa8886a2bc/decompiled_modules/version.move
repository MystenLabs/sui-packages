module 0xbf920079481262149317a7c4fd861061618a800445ce9875037fb3aa8886a2bc::version {
    public fun migrate(arg0: &mut 0xbf920079481262149317a7c4fd861061618a800445ce9875037fb3aa8886a2bc::project_manager::ProjectManagerConfig, arg1: &mut 0xbf920079481262149317a7c4fd861061618a800445ce9875037fb3aa8886a2bc::milestone::VestingConfig, arg2: &0xbf920079481262149317a7c4fd861061618a800445ce9875037fb3aa8886a2bc::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0xbf920079481262149317a7c4fd861061618a800445ce9875037fb3aa8886a2bc::launchpad_manager::LaunchpadManager) {
        0xbf920079481262149317a7c4fd861061618a800445ce9875037fb3aa8886a2bc::project_manager::migrate(arg0);
        0xbf920079481262149317a7c4fd861061618a800445ce9875037fb3aa8886a2bc::milestone::migrate(arg1);
        0xbf920079481262149317a7c4fd861061618a800445ce9875037fb3aa8886a2bc::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

