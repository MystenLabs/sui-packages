module 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::math {
    public fun calculate_apy(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0 || arg2 == 0) {
            0
        } else {
            arg0 * 365 * 10000 / arg1 * arg2
        }
    }

    public fun calculate_assets(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0 || arg0 == 0) {
            0
        } else {
            arg0 * arg1 / arg2
        }
    }

    public fun calculate_compound_interest(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            arg0
        } else {
            arg0 + arg0 * arg1 * arg2 / 10000
        }
    }

    public fun calculate_exchange_rate(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            1000000000
        } else {
            arg0 * 1000000000 / arg1
        }
    }

    public fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 10000
    }

    public fun calculate_shares(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 400);
        if (arg2 == 0) {
            arg0
        } else {
            assert!(arg1 > 0, 401);
            (arg0 * arg2 + arg1 - 1) / arg1
        }
    }

    public fun calculate_simple_interest(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 * arg1 * arg2 / 3650000
    }

    // decompiled from Move bytecode v6
}

