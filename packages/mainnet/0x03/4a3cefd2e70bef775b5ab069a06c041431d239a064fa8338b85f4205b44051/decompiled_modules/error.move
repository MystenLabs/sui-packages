module 0x34a3cefd2e70bef775b5ab069a06c041431d239a064fa8338b85f4205b44051::error {
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

