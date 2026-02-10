module 0xe5c7ec1641731e9c36f42b1fd1b806d51d20ac53a33552671261bf0361ec9273::constants {
    public fun b9_scaling() : u256 {
        1000000000
    }

    public fun default_lp_coin_image() : vector<u8> {
        b"https://aftermath.finance/coins/perpetuals/default.svg"
    }

    public fun force_withdraw_pause_ms() : u64 {
        10000
    }

    public fun lp_decimals() : u8 {
        9
    }

    public fun max_force_withdraw_delay() : u64 {
        86400000
    }

    public fun max_lock_period() : u64 {
        1209600000
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
        950000000000000000
    }

    public fun min_force_withdraw_position_usd() : u256 {
        5000000000000000000
    }

    public fun min_owner_lock_usd() : u256 {
        1000000000000000000
    }

    public fun min_pause_vault_for_force_withdraw_frequency_ms() : u64 {
        1800000
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

