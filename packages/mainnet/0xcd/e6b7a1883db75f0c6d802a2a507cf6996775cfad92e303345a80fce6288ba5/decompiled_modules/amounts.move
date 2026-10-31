module 0x1fbcc2f95306b6db869466c8b2c1461d5102b158584cced9036ee758c4b8cfce::amounts {
    public fun combat_tokens() : u64 {
        100000000 * 1000000000
    }

    public fun community_tokens() : u64 {
        110000000 * 1000000000
    }

    public fun duration_ms() : u64 {
        157680000000
    }

    public fun initial_supply() : u64 {
        1000000000 * 1000000000
    }

    public fun mastery_price(arg0: u64) : u64 {
        let v0 = (arg0 as u128) * (1000000000000 as u128);
        assert!(v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    public fun mastery_tokens() : u64 {
        1000
    }

    public fun reserve_tokens() : u64 {
        staking_tokens() + combat_tokens() + community_tokens()
    }

    public fun staking_tokens() : u64 {
        200000000 * 1000000000
    }

    public fun team_tokens() : u64 {
        30000000 * 1000000000
    }

    public fun unit() : u64 {
        1000000000
    }

    // decompiled from Move bytecode v7
}

