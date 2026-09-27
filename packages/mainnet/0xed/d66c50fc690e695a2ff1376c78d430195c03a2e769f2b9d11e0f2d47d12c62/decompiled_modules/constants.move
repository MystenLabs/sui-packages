module 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants {
    public fun bps_denominator() : u64 {
        10000
    }

    public fun game_credits_fixed_supply() : u64 {
        game_credits_max_supply()
    }

    public fun game_credits_max_supply() : u64 {
        1000000000000000
    }

    public fun max_burn_bps() : u64 {
        10000
    }

    public fun min_burn_bps() : u64 {
        2000
    }

    public fun one_token() : u64 {
        100000000
    }

    public fun reserve_contribution_cap_bps() : u64 {
        10
    }

    public fun reserve_contribution_cap_disable_supply() : u64 {
        9000000000000000
    }

    public fun reserve_contribution_window_ms() : u64 {
        7200000
    }

    public fun rflh_burn_curve_start() : u64 {
        2000000000000000
    }

    public fun rflh_initial_supply() : u64 {
        1000000000000000
    }

    public fun rflh_soft_cap() : u64 {
        10000000000000000
    }

    public fun treasury_cap() : u64 {
        1000000000000000
    }

    // decompiled from Move bytecode v7
}

