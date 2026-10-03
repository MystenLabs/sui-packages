module 0xfa208560e94310fa66c79df8b9aa1a33b5e3601781906833472ef233388e1e43::guard {
    public fun assert_min_value<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    // decompiled from Move bytecode v7
}

