module 0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::error {
    public fun insufficient_collateral() : u64 {
        0
    }

    public fun invalid_slippage() : u64 {
        3
    }

    public fun not_whitelisted() : u64 {
        2
    }

    public fun profit_below_minimum() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

