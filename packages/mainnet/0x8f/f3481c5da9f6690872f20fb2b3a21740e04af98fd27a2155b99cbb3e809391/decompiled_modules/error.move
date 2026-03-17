module 0x8ff3481c5da9f6690872f20fb2b3a21740e04af98fd27a2155b99cbb3e809391::error {
    public fun balances_not_empty() : u64 {
        4
    }

    public fun flash_loan_debts_not_empty() : u64 {
        5
    }

    public fun insufficient_balance() : u64 {
        3
    }

    public fun invalid_coin_type() : u64 {
        2
    }

    public fun invalid_protocol_id() : u64 {
        6
    }

    public fun invalid_slippage() : u64 {
        1
    }

    public fun not_whitelisted() : u64 {
        0
    }

    public fun package_not_whitelisted() : u64 {
        7
    }

    // decompiled from Move bytecode v6
}

