module 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::constants {
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

