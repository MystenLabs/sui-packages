module 0x37678debdaa6a1acfaa94aaa649fe1a8f320a02c1661f0fe001a0441c2c0c6d1::error {
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

