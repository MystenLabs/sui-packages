module 0x4f0777c1d88297c17de9adf59abb736c96f9deab679a34d6dd3e24fccad03829::margin_constants {
    public fun default_pool_liquidation_reward() : u64 {
        40000000
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

