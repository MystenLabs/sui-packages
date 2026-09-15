module 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::exposure_policy {
    public fun assert_leverage(arg0: u64) {
        assert!(arg0 >= 10000 && arg0 <= 200000, 1);
    }

    public fun closing_side(arg0: bool) : bool {
        arg0
    }

    public fun entry_notional(arg0: u64, arg1: u64) : u64 {
        assert_leverage(arg1);
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun max_leverage_bps() : u64 {
        200000
    }

    public fun min_leverage_bps() : u64 {
        10000
    }

    public fun opening_side(arg0: bool) : bool {
        !arg0
    }

    // decompiled from Move bytecode v7
}

