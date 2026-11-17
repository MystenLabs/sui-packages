module 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::u256 {
    public fun amounts_for_liquidity(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : (u64, u64) {
        let (v0, v1) = amounts_for_liquidity_wide(arg0, arg1, arg2, arg3);
        (to_u64(v0), to_u64(v1))
    }

    public fun amounts_for_liquidity_wide(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : (u256, u256) {
        if (arg0 == 0) {
            return (0, 0)
        };
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg2 as u256);
        let v3 = (arg3 as u256);
        if (v3 <= v1) {
            (delta_a(v0, v1, v2), 0)
        } else if (v3 >= v2) {
            (0, delta_b(v0, v1, v2))
        } else {
            (delta_a(v0, v3, v2), delta_b(v0, v1, v3))
        }
    }

    fun delta_a(arg0: u256, arg1: u256, arg2: u256) : u256 {
        (liquidity_times_width(arg0, arg1, arg2) << 64) / arg1 * arg2
    }

    fun delta_b(arg0: u256, arg1: u256, arg2: u256) : u256 {
        liquidity_times_width(arg0, arg1, arg2) >> 64
    }

    fun liquidity_times_width(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = arg0 * (arg2 - arg1);
        assert!(v0 < 6277101735386680763835789423207666416102355444464034512896, 451);
        v0
    }

    public fun sqrt(arg0: u256) : u256 {
        let v0 = 0;
        let v1 = 28948022309329048855892746252171976963317496166410141009864396001978282409984;
        while (v1 != 0) {
            if (arg0 >= v0 + v1) {
                arg0 = arg0 - v0 + v1;
                let v2 = v0 >> 1;
                v0 = v2 + v1;
            } else {
                v0 = v0 >> 1;
            };
            v1 = v1 >> 2;
        };
        v0
    }

    public fun sqrt_price_from_quotes(arg0: u128, arg1: u128) : u128 {
        assert!(arg1 != 0, 450);
        (sqrt(((arg0 as u256) << 128) / (arg1 as u256)) as u128)
    }

    fun to_u64(arg0: u256) : u64 {
        assert!(arg0 <= 18446744073709551615, 452);
        (arg0 as u64)
    }

    // decompiled from Move bytecode v7
}

