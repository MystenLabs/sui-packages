module 0x34388e8331a382b664f6d828d1347b8a0a7318b9f87fdb674987637aad87850a::error {
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

