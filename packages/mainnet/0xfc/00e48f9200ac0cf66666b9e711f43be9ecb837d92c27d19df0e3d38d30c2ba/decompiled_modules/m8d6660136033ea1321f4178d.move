module 0xfc00e48f9200ac0cf66666b9e711f43be9ecb837d92c27d19df0e3d38d30c2ba::m8d6660136033ea1321f4178d {
    public(friend) fun fc876086f014abbab01f9360a<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 <= 18446744073709551615 - arg2, 1);
        assert!(0x2::coin::value<T0>(&arg0) >= arg1 + arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public(friend) fun fce66912f4b6c0425e71a2434(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) <= arg1, 0);
    }

    // decompiled from Move bytecode v7
}

