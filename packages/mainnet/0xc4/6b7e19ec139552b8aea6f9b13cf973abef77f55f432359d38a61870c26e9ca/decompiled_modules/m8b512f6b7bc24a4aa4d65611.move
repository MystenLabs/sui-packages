module 0xc46b7e19ec139552b8aea6f9b13cf973abef77f55f432359d38a61870c26e9ca::m8b512f6b7bc24a4aa4d65611 {
    public(friend) fun fb2be96a7df6b5accc6d6da88(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) <= arg1, 0);
    }

    public(friend) fun fff511e74656c2a2992fbcb97<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 <= 18446744073709551615 - arg2, 1);
        assert!(0x2::coin::value<T0>(&arg0) >= arg1 + arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

