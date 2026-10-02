module 0xf93e3eb03090e457fea3b3b26520aea79ae16e7022623ada940c0d04bbf8dc65::guard {
    public fun assert_coin_gte<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 2);
    }

    public fun assert_gte(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 1);
    }

    public fun require_spread(arg0: u64, arg1: u64, arg2: u64) {
        let (v0, v1) = if (arg0 >= arg1) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        assert!(((v0 - v1) as u128) * 10000 / ((v1 + (v0 - v1) / 2) as u128) >= (arg2 as u128), 3);
    }

    // decompiled from Move bytecode v7
}

