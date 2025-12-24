module 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_constants {
    public fun day_ms() : u64 {
        86400000
    }

    public fun default_pool_liquidation_reward() : u64 {
        40000000
    }

    public fun default_referral() : 0x2::object::ID {
        0x2::object::id_from_address(@0x0)
    }

    public fun default_user_liquidation_reward() : u64 {
        10000000
    }

    public fun margin_version() : u64 {
        1
    }

    public fun max_conditional_orders() : u64 {
        10
    }

    public fun max_conf_bps() : u64 {
        10000
    }

    public fun max_ewma_difference_bps() : u64 {
        10000
    }

    public fun max_leverage() : u64 {
        20000000000
    }

    public fun max_margin_managers() : u64 {
        100
    }

    public fun max_protocol_spread() : u64 {
        200000000
    }

    public fun max_risk_ratio() : u64 {
        1000000000000
    }

    public fun min_leverage() : u64 {
        1000000000
    }

    public fun min_liquidation_repay() : u64 {
        1000
    }

    public fun min_min_borrow() : u64 {
        1000
    }

    public fun year_ms() : u64 {
        31536000000
    }

    // decompiled from Move bytecode v6
}

