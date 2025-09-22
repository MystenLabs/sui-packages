module 0xa7c46b6a994c0b10e8b09de5faa22884d0bd03c8deefd5081ae3ea830673af2a::version {
    public fun migrate(arg0: &mut 0xa7c46b6a994c0b10e8b09de5faa22884d0bd03c8deefd5081ae3ea830673af2a::project_manager::ProjectManagerConfig, arg1: &mut 0xa7c46b6a994c0b10e8b09de5faa22884d0bd03c8deefd5081ae3ea830673af2a::milestone::VestingConfig, arg2: &0xa7c46b6a994c0b10e8b09de5faa22884d0bd03c8deefd5081ae3ea830673af2a::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0xa7c46b6a994c0b10e8b09de5faa22884d0bd03c8deefd5081ae3ea830673af2a::launchpad_manager::LaunchpadManager) {
        0xa7c46b6a994c0b10e8b09de5faa22884d0bd03c8deefd5081ae3ea830673af2a::project_manager::migrate(arg0);
        0xa7c46b6a994c0b10e8b09de5faa22884d0bd03c8deefd5081ae3ea830673af2a::milestone::migrate(arg1);
        0xa7c46b6a994c0b10e8b09de5faa22884d0bd03c8deefd5081ae3ea830673af2a::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

