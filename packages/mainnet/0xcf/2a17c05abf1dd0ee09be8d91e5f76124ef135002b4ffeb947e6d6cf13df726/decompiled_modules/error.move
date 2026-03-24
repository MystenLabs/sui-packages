module 0xcf2a17c05abf1dd0ee09be8d91e5f76124ef135002b4ffeb947e6d6cf13df726::error {
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

