module 0xbb3ad6160364a67dbdd2499486c3b59b3ed34235e4af9d924d33ec34074a6f9b::math {
    public fun max_amount_in(arg0: u64, arg1: u64) : u64 {
        arg0 + arg0 * arg1 / 10000
    }

    public fun min_amount_out(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 * arg1 / 10000;
        if (arg0 <= v0) {
            return 0
        };
        arg0 - v0
    }

    public fun price_ratio(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        arg0 * 1000000 / arg1
    }

    public fun profit_percentage(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        if (arg1 <= arg0) {
            return 0
        };
        (arg1 - arg0) * 100 / arg0
    }

    // decompiled from Move bytecode v6
}

