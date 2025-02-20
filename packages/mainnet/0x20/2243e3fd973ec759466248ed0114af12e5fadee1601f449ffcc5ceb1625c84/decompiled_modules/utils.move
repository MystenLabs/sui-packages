module 0x202243e3fd973ec759466248ed0114af12e5fadee1601f449ffcc5ceb1625c84::utils {
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

    public fun refund_if_necessary<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

