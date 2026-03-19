module 0xfd24188d3b2d1aff05829d2bf19ccb331844aefddd969dd4638f04feff715062::error {
    public fun balances_not_empty() : u64 {
        3
    }

    public fun flash_loan_debts_not_empty() : u64 {
        4
    }

    public fun insufficient_balance() : u64 {
        2
    }

    public fun invalid_coin_type() : u64 {
        1
    }

    public fun invalid_protocol_id() : u64 {
        5
    }

    public fun invalid_repay_amount() : u64 {
        7
    }

    public fun not_whitelisted() : u64 {
        0
    }

    public fun package_not_whitelisted() : u64 {
        6
    }

    // decompiled from Move bytecode v6
}

