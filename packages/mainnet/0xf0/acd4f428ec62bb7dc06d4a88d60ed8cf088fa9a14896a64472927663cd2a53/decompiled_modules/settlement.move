module 0xa8f7b7893fd8edb8510b98e0cf19e9ea27b714c861113c79ca062ef96b2b378d::settlement {
    public fun assert_min_value<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 1);
    }

    public fun settle<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: address) {
        assert_min_value<T0>(&arg0, arg1);
        0x2::balance::send_funds<T0>(arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

