module 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_constants {
    public fun default_pool_liquidation_reward() : u64 {
        40000000
    }

    public fun default_referral() : address {
        @0x0
    }

    public fun default_user_liquidation_reward() : u64 {
        10000000
    }

    public fun margin_version() : u64 {
        1
    }

    public fun max_leverage() : u64 {
        20000000000
    }

    public fun max_margin_managers() : u64 {
        100
    }

    public fun max_risk_ratio() : u64 {
        1000000000000
    }

    public fun min_leverage() : u64 {
        1000000000
    }

    public fun min_min_borrow() : u64 {
        1000
    }

    public fun year_ms() : u64 {
        31536000000
    }

    // decompiled from Move bytecode v6
}

