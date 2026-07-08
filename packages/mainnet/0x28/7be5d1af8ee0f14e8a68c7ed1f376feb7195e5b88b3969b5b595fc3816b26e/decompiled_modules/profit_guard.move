module 0x287be5d1af8ee0f14e8a68c7ed1f376feb7195e5b88b3969b5b595fc3816b26e::profit_guard {
    public fun assert_min_value<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 1);
        arg0
    }

    public fun assert_min_value_and_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

