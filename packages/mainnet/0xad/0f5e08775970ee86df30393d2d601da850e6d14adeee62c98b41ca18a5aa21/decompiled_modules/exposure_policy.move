module 0xad0f5e08775970ee86df30393d2d601da850e6d14adeee62c98b41ca18a5aa21::exposure_policy {
    public fun assert_leverage(arg0: u64) {
        assert!(arg0 >= 10000 && arg0 <= 20000, 1);
    }

    public fun closing_side(arg0: bool) : bool {
        arg0
    }

    public fun entry_notional(arg0: u64, arg1: u64) : u64 {
        assert_leverage(arg1);
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun max_leverage_bps() : u64 {
        20000
    }

    public fun min_leverage_bps() : u64 {
        10000
    }

    public fun opening_side(arg0: bool) : bool {
        !arg0
    }

    // decompiled from Move bytecode v7
}

