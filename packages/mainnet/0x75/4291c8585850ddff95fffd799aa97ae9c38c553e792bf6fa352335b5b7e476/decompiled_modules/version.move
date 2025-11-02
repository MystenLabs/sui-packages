module 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::version {
    public fun migrate(arg0: &mut 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::project_manager::ProjectManagerConfig, arg1: &mut 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::milestone::VestingConfig, arg2: &0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::launchpad_manager::LaunchpadManager) {
        0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::project_manager::migrate(arg0);
        0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::milestone::migrate(arg1);
        0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

