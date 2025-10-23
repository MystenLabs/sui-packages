module 0xf5ebd028e89769e49de0012346c04477bbf35274a9fa5a03a0421c20144f573c::errors {
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

    public fun err_amount_is_zero() : u64 {
        15
    }

    public fun err_balance_not_enough() : u64 {
        14
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

    public fun nft_not_found() : u64 {
        16
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

