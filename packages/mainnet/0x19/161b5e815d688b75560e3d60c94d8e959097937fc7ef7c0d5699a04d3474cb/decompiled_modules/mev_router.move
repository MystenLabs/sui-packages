module 0x7e7d1eaf043d2d27234150408aa31ccd8b9449e4604ae97400edeb5306fffc89::mev_router {
    public fun assert_profit<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1001);
    }

    public fun enforce_min_out<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1001);
    }

    // decompiled from Move bytecode v7
}

