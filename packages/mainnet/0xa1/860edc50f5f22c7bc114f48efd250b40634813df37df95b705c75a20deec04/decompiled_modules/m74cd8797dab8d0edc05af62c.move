module 0xa1860edc50f5f22c7bc114f48efd250b40634813df37df95b705c75a20deec04::m74cd8797dab8d0edc05af62c {
    public(friend) fun f01c1834ea1d1c3cf1f10d603(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) <= arg1, 0);
    }

    public(friend) fun f59f2e3fed87e88c747e70d7d<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 <= 18446744073709551615 - arg2, 1);
        assert!(0x2::coin::value<T0>(&arg0) >= arg1 + arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

