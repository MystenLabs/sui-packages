module 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::constants {
    public fun bps_denominator() : u16 {
        10000
    }

    public fun collect_receipt_ttl_ms() : u64 {
        21600000
    }

    public fun cumulative_window_ms() : u64 {
        3600000
    }

    public fun max_apy_e9() : u64 {
        440000000
    }

    public fun max_global_pause_ttl_ms() : u64 {
        604800000
    }

    public fun max_inventory_snapshot() : u64 {
        10000
    }

    public fun max_scoped_pause_ttl_ms() : u64 {
        86400000
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

