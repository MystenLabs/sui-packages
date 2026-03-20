module 0xe2e3ba3661471a1a3af5550e8dee9ec71aeb2134a2aa3bc287e8b6a8a492147d::error {
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

