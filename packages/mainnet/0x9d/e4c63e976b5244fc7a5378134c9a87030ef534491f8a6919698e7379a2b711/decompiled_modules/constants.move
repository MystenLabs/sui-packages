module 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants {
    struct ExtKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun bps_denom() : u64 {
        10000
    }

    public fun default_marketplace_fee_bps() : u16 {
        250
    }

    public fun default_max_royalty_bps() : u16 {
        1000
    }

    public fun err_already_bootstrapped() : u64 {
        101
    }

    public fun err_bounty_completed() : u64 {
        113
    }

    public fun err_bounty_deadline() : u64 {
        110
    }

    public fun err_bounty_still_active() : u64 {
        116
    }

    public fun err_bounty_zero() : u64 {
        111
    }

    public fun err_ext_exists() : u64 {
        103
    }

    public fun err_fork_depth() : u64 {
        105
    }

    public fun err_no_accepted() : u64 {
        117
    }

    public fun err_no_ext() : u64 {
        104
    }

    public fun err_no_submission() : u64 {
        114
    }

    public fun err_not_bootstrapped() : u64 {
        102
    }

    public fun err_not_listed() : u64 {
        106
    }

    public fun err_not_poster() : u64 {
        112
    }

    public fun err_not_seller() : u64 {
        107
    }

    public fun err_paused() : u64 {
        100
    }

    public fun err_price_too_low() : u64 {
        108
    }

    public fun err_split_overflow() : u64 {
        109
    }

    public fun err_submission_not_found() : u64 {
        115
    }

    public fun ext_key() : ExtKey {
        ExtKey{dummy_field: false}
    }

    public fun lineage_pool_bps() : u16 {
        500
    }

    public fun max_fork_depth() : u16 {
        8
    }

    public fun max_royalty_bps() : u16 {
        1000
    }

    // decompiled from Move bytecode v7
}

