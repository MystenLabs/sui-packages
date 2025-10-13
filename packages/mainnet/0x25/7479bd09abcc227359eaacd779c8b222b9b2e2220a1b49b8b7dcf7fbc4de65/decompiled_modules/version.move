module 0x257479bd09abcc227359eaacd779c8b222b9b2e2220a1b49b8b7dcf7fbc4de65::version {
    public fun migrate(arg0: &mut 0x257479bd09abcc227359eaacd779c8b222b9b2e2220a1b49b8b7dcf7fbc4de65::project_manager::ProjectManagerConfig, arg1: &mut 0x257479bd09abcc227359eaacd779c8b222b9b2e2220a1b49b8b7dcf7fbc4de65::milestone::VestingConfig, arg2: &0x257479bd09abcc227359eaacd779c8b222b9b2e2220a1b49b8b7dcf7fbc4de65::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0x257479bd09abcc227359eaacd779c8b222b9b2e2220a1b49b8b7dcf7fbc4de65::launchpad_manager::LaunchpadManager) {
        0x257479bd09abcc227359eaacd779c8b222b9b2e2220a1b49b8b7dcf7fbc4de65::project_manager::migrate(arg0);
        0x257479bd09abcc227359eaacd779c8b222b9b2e2220a1b49b8b7dcf7fbc4de65::milestone::migrate(arg1);
        0x257479bd09abcc227359eaacd779c8b222b9b2e2220a1b49b8b7dcf7fbc4de65::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

