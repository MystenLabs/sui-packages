module 0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::utils {
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

