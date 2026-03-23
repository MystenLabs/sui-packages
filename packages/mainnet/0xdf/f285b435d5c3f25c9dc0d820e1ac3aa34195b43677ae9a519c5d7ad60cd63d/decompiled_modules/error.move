module 0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::error {
    public fun balances_not_empty() : u64 {
        3
    }

    public fun insufficient_balance() : u64 {
        2
    }

    public fun invalid_coin_type() : u64 {
        1
    }

    public fun not_whitelisted() : u64 {
        0
    }

    public fun package_not_whitelisted() : u64 {
        6
    }

    // decompiled from Move bytecode v6
}

