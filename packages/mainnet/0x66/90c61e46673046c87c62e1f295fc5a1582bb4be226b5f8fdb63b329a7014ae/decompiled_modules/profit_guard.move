module 0x6690c61e46673046c87c62e1f295fc5a1582bb4be226b5f8fdb63b329a7014ae::profit_guard {
    public fun assert_min_profit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 1);
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 2);
        arg0
    }

    // decompiled from Move bytecode v6
}

