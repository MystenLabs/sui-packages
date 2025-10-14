module 0x801111fd06ce0f3638dbc3a14d49ad7c4c797eaa72aae44796ec662ed8c6d448::version {
    public fun migrate(arg0: &mut 0x801111fd06ce0f3638dbc3a14d49ad7c4c797eaa72aae44796ec662ed8c6d448::project_manager::ProjectManagerConfig, arg1: &mut 0x801111fd06ce0f3638dbc3a14d49ad7c4c797eaa72aae44796ec662ed8c6d448::milestone::VestingConfig, arg2: &0x801111fd06ce0f3638dbc3a14d49ad7c4c797eaa72aae44796ec662ed8c6d448::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0x801111fd06ce0f3638dbc3a14d49ad7c4c797eaa72aae44796ec662ed8c6d448::launchpad_manager::LaunchpadManager) {
        0x801111fd06ce0f3638dbc3a14d49ad7c4c797eaa72aae44796ec662ed8c6d448::project_manager::migrate(arg0);
        0x801111fd06ce0f3638dbc3a14d49ad7c4c797eaa72aae44796ec662ed8c6d448::milestone::migrate(arg1);
        0x801111fd06ce0f3638dbc3a14d49ad7c4c797eaa72aae44796ec662ed8c6d448::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

