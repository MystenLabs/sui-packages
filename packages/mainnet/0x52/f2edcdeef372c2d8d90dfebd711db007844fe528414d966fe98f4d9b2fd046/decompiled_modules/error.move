module 0x52f2edcdeef372c2d8d90dfebd711db007844fe528414d966fe98f4d9b2fd046::error {
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

