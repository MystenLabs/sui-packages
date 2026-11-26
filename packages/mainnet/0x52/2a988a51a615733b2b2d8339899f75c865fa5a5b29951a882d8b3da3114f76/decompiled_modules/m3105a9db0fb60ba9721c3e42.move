module 0x522a988a51a615733b2b2d8339899f75c865fa5a5b29951a882d8b3da3114f76::m3105a9db0fb60ba9721c3e42 {
    public(friend) fun f8f8d41384e7a31ab80b0a606(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) <= arg1, 0);
    }

    public(friend) fun ff5e1c244d571bcbe6ac51873<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 <= 18446744073709551615 - arg2, 1);
        assert!(0x2::coin::value<T0>(&arg0) >= arg1 + arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

