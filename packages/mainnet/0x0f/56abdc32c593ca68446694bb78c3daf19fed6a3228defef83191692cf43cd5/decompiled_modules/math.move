module 0xf56abdc32c593ca68446694bb78c3daf19fed6a3228defef83191692cf43cd5::math {
    public fun calculate_arbitrage_profit(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 > arg0) {
            arg2 - arg0
        } else {
            0
        }
    }

    public fun calculate_min_output(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 1000, 2);
        arg0 * (10000 - arg1) / 10000
    }

    public fun calculate_price_ratio(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 1);
        arg0 * 1000000000 / arg1
    }

    public fun get_precision_factor() : u64 {
        1000000000
    }

    public fun validate_amount_bounds(arg0: u64) : bool {
        arg0 > 0 && arg0 < 9223372036854775808
    }

    // decompiled from Move bytecode v6
}

