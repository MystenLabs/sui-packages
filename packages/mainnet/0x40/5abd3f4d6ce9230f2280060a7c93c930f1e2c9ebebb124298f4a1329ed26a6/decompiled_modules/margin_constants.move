module 0x405abd3f4d6ce9230f2280060a7c93c930f1e2c9ebebb124298f4a1329ed26a6::margin_constants {
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

