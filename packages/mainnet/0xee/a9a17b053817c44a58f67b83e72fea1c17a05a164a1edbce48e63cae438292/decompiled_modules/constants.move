module 0xbccd998a04063ba11378af805a9c36f3ccc376cafe9a381f56f36cb3046e9c4b::constants {
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

    public(friend) fun max_assistants_per_vault() : u64 {
        10
    }

    public fun max_force_withdraw_delay() : u64 {
        86400000
    }

    public fun max_lock_period() : u64 {
        1209600000
    }

    public fun max_markets_in_vault() : u64 {
        15
    }

    public fun max_owner_fee_rate() : u256 {
        200000000000000000
    }

    public fun max_owner_lock_usd() : u256 {
        2000000000000000000
    }

    public fun max_pending_orders_per_position() : u64 {
        60
    }

    public fun min_deposit_usd() : u256 {
        950000000000000000
    }

    public fun min_owner_lock_usd() : u256 {
        1000000000000000000
    }

    public fun u256_max() : u256 {
        115792089237316195423570985008687907853269984665640564039457584007913129639935
    }

    public fun version() : u64 {
        3
    }

    // decompiled from Move bytecode v6
}

