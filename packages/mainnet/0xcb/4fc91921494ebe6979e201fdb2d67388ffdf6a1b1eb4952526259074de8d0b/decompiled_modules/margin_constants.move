module 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_constants {
    public fun day_ms() : u64 {
        86400000
    }

    public fun default_max_price_age_ms() : u64 {
        300000
    }

    public fun default_pool_liquidation_reward() : u64 {
        40000000
    }

    public fun default_price_tolerance() : u64 {
        50000000
    }

    public fun default_referral() : 0x2::object::ID {
        0x2::object::id_from_address(@0x0)
    }

    public fun default_user_liquidation_reward() : u64 {
        10000000
    }

    public fun margin_version() : u64 {
        2
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

    public fun max_price_age_ms() : u64 {
        3600000
    }

    public fun max_price_tolerance() : u64 {
        500000000
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

    public fun min_price_age_ms() : u64 {
        30000
    }

    public fun min_price_tolerance() : u64 {
        10000000
    }

    public fun year_ms() : u64 {
        31536000000
    }

    // decompiled from Move bytecode v6
}

