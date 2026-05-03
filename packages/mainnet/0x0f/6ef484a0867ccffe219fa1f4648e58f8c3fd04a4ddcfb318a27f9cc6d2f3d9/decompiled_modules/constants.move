module 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::constants {
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

