module 0xe01e0b4ae15f9e3fab6a3318714cd4555b53b78d40b39aff1e1e1be80e2b376e::version {
    public fun migrate(arg0: &mut 0xe01e0b4ae15f9e3fab6a3318714cd4555b53b78d40b39aff1e1e1be80e2b376e::project_manager::ProjectManagerConfig, arg1: &mut 0xe01e0b4ae15f9e3fab6a3318714cd4555b53b78d40b39aff1e1e1be80e2b376e::milestone::VestingConfig, arg2: &0xe01e0b4ae15f9e3fab6a3318714cd4555b53b78d40b39aff1e1e1be80e2b376e::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0xe01e0b4ae15f9e3fab6a3318714cd4555b53b78d40b39aff1e1e1be80e2b376e::launchpad_manager::LaunchpadManager) {
        0xe01e0b4ae15f9e3fab6a3318714cd4555b53b78d40b39aff1e1e1be80e2b376e::project_manager::migrate(arg0);
        0xe01e0b4ae15f9e3fab6a3318714cd4555b53b78d40b39aff1e1e1be80e2b376e::milestone::migrate(arg1);
        0xe01e0b4ae15f9e3fab6a3318714cd4555b53b78d40b39aff1e1e1be80e2b376e::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

