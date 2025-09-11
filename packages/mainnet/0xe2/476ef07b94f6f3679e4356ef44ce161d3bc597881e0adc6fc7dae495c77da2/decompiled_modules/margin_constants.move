module 0xe2476ef07b94f6f3679e4356ef44ce161d3bc597881e0adc6fc7dae495c77da2::margin_constants {
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

