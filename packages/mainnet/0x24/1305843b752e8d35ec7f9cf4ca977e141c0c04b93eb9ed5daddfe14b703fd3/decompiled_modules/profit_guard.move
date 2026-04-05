module 0x241305843b752e8d35ec7f9cf4ca977e141c0c04b93eb9ed5daddfe14b703fd3::profit_guard {
    public fun assert_min_output<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 0);
    }

    // decompiled from Move bytecode v7
}

