module 0x5674af893d0dc90e4892d409d025097d60ebe9860d64b91293ed2782b264adb9::math {
    public fun calculate_min_output(arg0: u64, arg1: u64) : u64 {
        arg0 * (10000 - arg1) / 10000
    }

    public fun is_profitable(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg1 > arg0 + arg2
    }

    public fun price_ratio(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        arg0 * 10000 / arg1
    }

    public fun safe_mul(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 == 0 || 18446744073709551615 / arg0 >= arg1, 0);
        arg0 * arg1
    }

    // decompiled from Move bytecode v6
}

