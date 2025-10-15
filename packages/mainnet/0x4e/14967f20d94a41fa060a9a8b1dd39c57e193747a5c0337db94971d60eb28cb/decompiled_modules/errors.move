module 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::errors {
    public fun adapter_not_whitelisted() : u64 {
        0
    }

    public fun agent_not_whitelisted() : u64 {
        10
    }

    public fun arithmetic_overflow() : u64 {
        29
    }

    public fun asset_already_exists() : u64 {
        12
    }

    public fun asset_not_found() : u64 {
        11
    }

    public fun asset_store_not_empty() : u64 {
        27
    }

    public fun asset_type_not_found() : u64 {
        7
    }

    public fun cannot_remove_rules_with_active_assets() : u64 {
        13
    }

    public fun config_asset_type_not_found() : u64 {
        9
    }

    public fun config_rule_not_found() : u64 {
        8
    }

    public fun division_by_zero() : u64 {
        30
    }

    public fun incorrect_activation_fee_amount() : u64 {
        22
    }

    public fun insufficient_activation_fee() : u64 {
        20
    }

    public fun insufficient_balance() : u64 {
        21
    }

    public fun invalid_account() : u64 {
        24
    }

    public fun invalid_acl() : u64 {
        23
    }

    public fun invalid_amount() : u64 {
        14
    }

    public fun invalid_asset_type_for_strategy() : u64 {
        18
    }

    public fun invalid_fee_rate() : u64 {
        28
    }

    public fun invalid_owner() : u64 {
        25
    }

    public fun invalid_owner_cap() : u64 {
        4
    }

    public fun no_positions_found() : u64 {
        26
    }

    public fun not_implemented() : u64 {
        15
    }

    public fun rule_already_exists() : u64 {
        6
    }

    public fun rule_not_found() : u64 {
        5
    }

    public fun strategy_already_exists() : u64 {
        16
    }

    public fun strategy_not_found() : u64 {
        17
    }

    public fun version_mismatch() : u64 {
        19
    }

    // decompiled from Move bytecode v6
}

