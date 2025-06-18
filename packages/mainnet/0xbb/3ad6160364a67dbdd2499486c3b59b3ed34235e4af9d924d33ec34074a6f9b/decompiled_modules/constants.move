module 0xbb3ad6160364a67dbdd2499486c3b59b3ed34235e4af9d924d33ec34074a6f9b::constants {
    public fun default_slippage_bps() : u64 {
        100
    }

    public fun max_slippage_bps() : u64 {
        500
    }

    public fun min_profit_bps() : u64 {
        10
    }

    public fun min_sui_amount() : u64 {
        10000000
    }

    public fun min_usdc_amount() : u64 {
        10000
    }

    public fun sui_decimals() : u8 {
        9
    }

    public fun usdc_decimals() : u8 {
        6
    }

    // decompiled from Move bytecode v6
}

