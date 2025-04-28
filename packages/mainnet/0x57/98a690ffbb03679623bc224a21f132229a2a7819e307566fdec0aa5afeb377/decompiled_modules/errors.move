module 0x3b46851fbebc00db929b0a60b2b81161dbb5c4a485af5f5bd49b4644d996d85b::errors {
    public fun already_paused() : u64 {
        10
    }

    public fun already_redeemed() : u64 {
        5
    }

    public fun already_unpaused() : u64 {
        11
    }

    public fun balance_not_enough() : u64 {
        9
    }

    public fun err_invalid_version() : u64 {
        12
    }

    public fun err_version_deprecated() : u64 {
        13
    }

    public fun lock_time_not_end() : u64 {
        7
    }

    public fun parameter_illegal() : u64 {
        1
    }

    public fun period_illegal() : u64 {
        8
    }

    public fun release_interval_error() : u64 {
        6
    }

    public fun time_illegal() : u64 {
        2
    }

    public fun vesting_paused() : u64 {
        3
    }

    public fun wrong_cap() : u64 {
        4
    }

    // decompiled from Move bytecode v6
}

