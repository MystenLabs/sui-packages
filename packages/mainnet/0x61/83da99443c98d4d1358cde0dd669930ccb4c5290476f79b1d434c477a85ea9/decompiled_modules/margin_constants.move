module 0x6183da99443c98d4d1358cde0dd669930ccb4c5290476f79b1d434c477a85ea9::margin_constants {
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

    public fun min_min_borrow() : u64 {
        1000
    }

    public fun year_ms() : u64 {
        31536000000
    }

    // decompiled from Move bytecode v6
}

