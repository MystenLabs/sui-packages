module 0x384ab5f72d0ef84e3b7e0f63b595e1f6d6ff6fb991160ae803458534c0795457::constants {
    public fun b9_scaling() : u256 {
        1000000000
    }

    public fun default_lp_coin_image() : vector<u8> {
        b"https://aftermath.finance/coins/perpetuals/default.svg"
    }

    public fun max_force_withdraw_delay() : u64 {
        86400000
    }

    public fun max_lock_period() : u64 {
        5184000000
    }

    public fun max_markets_in_vault() : u64 {
        12
    }

    public fun max_owner_fee_rate() : u256 {
        200000000000000000
    }

    public fun max_pending_orders_per_position() : u64 {
        70
    }

    public fun min_deposit_usd() : u256 {
        1000000000000000000
    }

    public fun min_force_withdraw_delay() : u64 {
        3600000
    }

    public fun min_lock_period() : u64 {
        3600000
    }

    public fun min_owner_fee_rate() : u256 {
        0
    }

    public fun min_owner_lock_usd() : u256 {
        10000000000000000000
    }

    public fun vault_params_update_frequency() : u64 {
        28800000
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

