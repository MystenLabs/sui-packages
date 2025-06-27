module 0xf9beba0ba21312766d4432bfb21a1fde93a956def853fd2371ab8da42bee6329::math {
    public fun calculate_optimal_amount(arg0: u64, arg1: u64) : u64 {
        if (arg0 <= arg1) {
            return 0
        };
        (arg0 - arg1) * 8000 / 10000
    }

    public fun calculate_percentage(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 10000
    }

    public fun calculate_price_impact(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 10000
        };
        let v0 = arg0 * 10000 / arg1;
        if (v0 > 10000) {
            10000
        } else {
            v0
        }
    }

    public fun calculate_profit(arg0: u64, arg1: u64) : (u64, bool) {
        if (arg1 > arg0) {
            (arg1 - arg0, true)
        } else {
            (arg0 - arg1, false)
        }
    }

    public fun calculate_swap_output(arg0: u64, arg1: u64) : u64 {
        arg0 - calculate_percentage(arg0, arg1)
    }

    public fun is_profitable(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg1 > arg0 + arg2
    }

    public fun safe_div(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        arg0 / arg1
    }

    public fun safe_mul(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        if (arg0 > 18446744073709551615 / arg1) {
            return 18446744073709551615
        };
        arg0 * arg1
    }

    // decompiled from Move bytecode v6
}

