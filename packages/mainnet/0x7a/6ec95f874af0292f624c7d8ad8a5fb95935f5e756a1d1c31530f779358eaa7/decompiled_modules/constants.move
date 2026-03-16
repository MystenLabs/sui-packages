module 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::constants {
    public fun auth_level_global_only() : u8 {
        0
    }

    public fun auth_level_permissive() : u8 {
        2
    }

    public fun auth_level_whitelist() : u8 {
        1
    }

    public fun current_action_version() : u8 {
        1
    }

    public fun max_action_data_size() : u64 {
        4096
    }

    public fun source_factory_init() : u8 {
        3
    }

    public fun source_launchpad_failure() : u8 {
        1
    }

    public fun source_launchpad_success() : u8 {
        0
    }

    public fun source_proposal() : u8 {
        2
    }

    // decompiled from Move bytecode v6
}

