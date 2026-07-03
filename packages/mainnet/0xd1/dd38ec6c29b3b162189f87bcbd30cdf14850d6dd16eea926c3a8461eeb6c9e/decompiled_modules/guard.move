module 0xd1dd38ec6c29b3b162189f87bcbd30cdf14850d6dd16eea926c3a8461eeb6c9e::guard {
    public fun assert_min_out<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 0);
        arg0
    }

    // decompiled from Move bytecode v6
}

