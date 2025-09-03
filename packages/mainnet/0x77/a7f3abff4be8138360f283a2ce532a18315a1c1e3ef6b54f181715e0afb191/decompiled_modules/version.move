module 0x77a7f3abff4be8138360f283a2ce532a18315a1c1e3ef6b54f181715e0afb191::version {
    public fun migrate(arg0: &mut 0x77a7f3abff4be8138360f283a2ce532a18315a1c1e3ef6b54f181715e0afb191::project_manager::ProjectManagerConfig, arg1: &mut 0x77a7f3abff4be8138360f283a2ce532a18315a1c1e3ef6b54f181715e0afb191::milestone::VestingConfig, arg2: &0x77a7f3abff4be8138360f283a2ce532a18315a1c1e3ef6b54f181715e0afb191::launchpad_manager_config::LaunchManagerAdmin) {
        0x77a7f3abff4be8138360f283a2ce532a18315a1c1e3ef6b54f181715e0afb191::project_manager::migrate(arg0);
        0x77a7f3abff4be8138360f283a2ce532a18315a1c1e3ef6b54f181715e0afb191::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

