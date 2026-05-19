module 0xa904a3e29f84c497a6dcfd6209ac41c1f22c0c0052c41b0b9fbef171b4f6d157::profit {
    public fun assert_min_profit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 0);
        arg0
    }

    // decompiled from Move bytecode v7
}

