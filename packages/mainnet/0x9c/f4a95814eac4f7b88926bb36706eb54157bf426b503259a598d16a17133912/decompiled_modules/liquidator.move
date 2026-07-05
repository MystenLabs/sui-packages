module 0x9cf4a95814eac4f7b88926bb36706eb54157bf426b503259a598d16a17133912::liquidator {
    public fun assert_min_usdc_out<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    // decompiled from Move bytecode v7
}

