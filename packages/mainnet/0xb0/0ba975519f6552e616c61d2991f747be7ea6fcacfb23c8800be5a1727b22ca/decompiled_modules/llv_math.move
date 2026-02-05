module 0xb00ba975519f6552e616c61d2991f747be7ea6fcacfb23c8800be5a1727b22ca::llv_math {
    public fun calculate_assets_for_shares(arg0: u128, arg1: u128, arg2: u128) : u128 {
        arg2 * (arg1 + 1000000) / (arg0 + 1000000)
    }

    public fun calculate_shares(arg0: u128, arg1: u128, arg2: u64) : u128 {
        (arg2 as u128) * (arg0 + 1000000) / (arg1 + 1000000)
    }

    public fun calculate_shares_for_assets(arg0: u128, arg1: u128, arg2: u64) : u128 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = arg1 + 1000000;
        ((arg2 as u128) * (arg0 + 1000000) + v0 - 1) / v0
    }

    public fun calculate_shares_with_min(arg0: u128, arg1: u128, arg2: u64) : u128 {
        let v0 = calculate_shares(arg0, arg1, arg2);
        assert!(v0 >= 1000, 1);
        v0
    }

    public fun calculate_yield_index(arg0: u128, arg1: u128) : u128 {
        if (arg0 == 0) {
            1000000000000000000
        } else {
            arg1 * 1000000000000000000 / arg0
        }
    }

    public fun min_shares() : u128 {
        1000
    }

    public fun mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 2);
        arg0 * arg1 / arg2
    }

    public fun scale() : u128 {
        1000000000000000000
    }

    public fun virtual_offset() : u128 {
        1000000
    }

    // decompiled from Move bytecode v6
}

