module 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::constants {
    public fun bps_denominator() : u16 {
        10000
    }

    public fun collect_receipt_ttl_ms() : u64 {
        60000
    }

    public fun cumulative_window_ms() : u64 {
        60000
    }

    public fun max_apy_e9() : u64 {
        440000000
    }

    public fun max_global_pause_ttl_ms() : u64 {
        60000
    }

    public fun max_inventory_snapshot() : u64 {
        10000
    }

    public fun max_scoped_pause_ttl_ms() : u64 {
        60000
    }

    public fun min_split_amount() : u64 {
        10000000000
    }

    public fun protocol_max_fee_bps() : u16 {
        2000
    }

    public fun protocol_max_yt_ratio_bps() : u16 {
        3000
    }

    // decompiled from Move bytecode v7
}

