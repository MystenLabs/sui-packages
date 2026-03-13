module 0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::error {
    public fun balances_not_empty() : u64 {
        4
    }

    public fun insufficient_balance() : u64 {
        3
    }

    public fun invalid_coin_type() : u64 {
        2
    }

    public fun invalid_slippage() : u64 {
        1
    }

    public fun not_whitelisted() : u64 {
        0
    }

    // decompiled from Move bytecode v6
}

