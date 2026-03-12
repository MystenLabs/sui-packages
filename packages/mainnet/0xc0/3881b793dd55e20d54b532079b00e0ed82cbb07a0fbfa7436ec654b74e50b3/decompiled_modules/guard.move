module 0xc03881b793dd55e20d54b532079b00e0ed82cbb07a0fbfa7436ec654b74e50b3::guard {
    public fun assert_min_balance<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 1);
    }

    public fun assert_min_profit<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64, arg2: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1 + arg2, 2);
    }

    // decompiled from Move bytecode v6
}

