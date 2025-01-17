module 0x9495a0f94e7a425f4d95d70307a4b672e6fc4f918d825a5875de85e11ad5a6b1::utils {
    public fun check_amount_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        if (0x2::coin::value<T0>(arg0) < arg1) {
            abort 1
        };
    }

    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) {
        if (0x2::clock::timestamp_ms(arg0) > arg1) {
            abort 0
        };
    }

    public fun check_slippage(arg0: u64) {
        if (arg0 > 1000000) {
            abort 2
        };
    }

    // decompiled from Move bytecode v6
}

