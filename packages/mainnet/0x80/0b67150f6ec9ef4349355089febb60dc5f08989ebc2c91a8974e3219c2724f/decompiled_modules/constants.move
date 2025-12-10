module 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::constants {
    public fun b9_scaling() : u256 {
        1000000000
    }

    public fun default_lp_coin_image() : vector<u8> {
        b"https://i.ibb.co/GV98MHf/Aftermath-Lp-Coin-Default.png"
    }

    public fun max_collateral_pfs_tolerance_ms() : u64 {
        10000
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

