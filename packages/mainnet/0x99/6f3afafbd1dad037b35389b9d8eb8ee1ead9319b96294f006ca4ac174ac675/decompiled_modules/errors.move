module 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors {
    public fun adapter_not_whitelisted() : u64 {
        0
    }

    public fun agent_not_whitelisted() : u64 {
        10
    }

    public fun asset_already_exists() : u64 {
        12
    }

    public fun asset_not_found() : u64 {
        11
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

    public fun invalid_amount() : u64 {
        14
    }

    public fun invalid_asset_type_for_strategy() : u64 {
        18
    }

    public fun invalid_owner_cap() : u64 {
        4
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

    // decompiled from Move bytecode v6
}

