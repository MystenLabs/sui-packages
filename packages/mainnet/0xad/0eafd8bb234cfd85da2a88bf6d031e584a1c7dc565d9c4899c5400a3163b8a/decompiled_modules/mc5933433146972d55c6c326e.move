module 0xad0eafd8bb234cfd85da2a88bf6d031e584a1c7dc565d9c4899c5400a3163b8a::mc5933433146972d55c6c326e {
    public(friend) fun f42703ddd39d085e04e5df3a2<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 <= 18446744073709551615 - arg2, 1);
        assert!(0x2::coin::value<T0>(&arg0) >= arg1 + arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public(friend) fun f68f8dc031dd28732f874087e(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) <= arg1, 0);
    }

    // decompiled from Move bytecode v7
}

