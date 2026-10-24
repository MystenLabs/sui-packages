module 0xa8f7b7893fd8edb8510b98e0cf19e9ea27b714c861113c79ca062ef96b2b378d::guard {
    public fun assert_min_value<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    public fun assert_profit<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64) {
        assert_min_value<T0>(arg0, arg1 + arg2);
    }

    // decompiled from Move bytecode v7
}

