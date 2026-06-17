module 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::constants {
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

