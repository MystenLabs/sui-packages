module 0x458a8971830f8363cf9359493d00e620442226529824907a27d39e998d9c2be5::version {
    public fun migrate(arg0: &mut 0x458a8971830f8363cf9359493d00e620442226529824907a27d39e998d9c2be5::project_manager::ProjectManagerConfig, arg1: &mut 0x458a8971830f8363cf9359493d00e620442226529824907a27d39e998d9c2be5::milestone::VestingConfig, arg2: &0x458a8971830f8363cf9359493d00e620442226529824907a27d39e998d9c2be5::launchpad_manager_config::LaunchManagerAdmin) {
        0x458a8971830f8363cf9359493d00e620442226529824907a27d39e998d9c2be5::project_manager::migrate(arg0);
        0x458a8971830f8363cf9359493d00e620442226529824907a27d39e998d9c2be5::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

