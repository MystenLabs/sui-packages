module 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::constants {
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

