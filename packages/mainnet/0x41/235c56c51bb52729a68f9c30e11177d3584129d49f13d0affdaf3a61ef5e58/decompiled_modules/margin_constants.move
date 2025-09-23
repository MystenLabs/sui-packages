module 0x41235c56c51bb52729a68f9c30e11177d3584129d49f13d0affdaf3a61ef5e58::margin_constants {
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

