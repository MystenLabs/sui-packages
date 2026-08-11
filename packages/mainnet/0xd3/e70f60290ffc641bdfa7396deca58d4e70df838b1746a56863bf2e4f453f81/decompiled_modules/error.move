module 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::error {
    public fun deposits_disabled() : u64 {
        5
    }

    public fun invalid_flow_id() : u64 {
        1
    }

    public fun invalid_harvest_cap() : u64 {
        7
    }

    public fun invalid_leverage() : u64 {
        2
    }

    public fun invalid_obligation() : u64 {
        4
    }

    public fun invalid_vault() : u64 {
        6
    }

    public fun invalid_vault_cap() : u64 {
        3
    }

    public fun position_not_closed() : u64 {
        12
    }

    public fun reward_balance_zero() : u64 {
        17
    }

    public fun reward_not_stored() : u64 {
        18
    }

    public fun sender_not_whitelisted() : u64 {
        8
    }

    public fun slippage_exceeded() : u64 {
        14
    }

    public fun unsettled_fees() : u64 {
        15
    }

    public fun vault_not_active() : u64 {
        9
    }

    public fun vault_not_finalized() : u64 {
        11
    }

    public fun vault_not_unwinding() : u64 {
        10
    }

    public fun vaults_wound_down() : u64 {
        16
    }

    public fun zero_amount() : u64 {
        13
    }

    // decompiled from Move bytecode v7
}

