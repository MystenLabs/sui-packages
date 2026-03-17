module 0x8bfbec444203e17f62fbfb7a18bab6c87be1720b4eb68ed6515db15c1cf6a062::oracle_constants {
    public fun both_type() : u8 {
        2
    }

    public fun default_decimal_limit() : u8 {
        16
    }

    public fun default_update_interval() : u64 {
        30000
    }

    public fun level_critical() : u8 {
        0
    }

    public fun level_major() : u8 {
        1
    }

    public fun level_normal() : u8 {
        3
    }

    public fun level_warning() : u8 {
        2
    }

    public fun multiple() : u64 {
        10000
    }

    public fun no_available_prices() : u8 {
        0
    }

    public fun primary_type() : u8 {
        0
    }

    public fun secondary_type() : u8 {
        1
    }

    public fun success() : u64 {
        1
    }

    public fun unavailable_prices() : u8 {
        1
    }

    public fun version() : u64 {
        3
    }

    // decompiled from Move bytecode v6
}

