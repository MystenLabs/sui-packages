module 0x1097af71793b72d62a5daeea9d9bb6df21a17c93ed25397894cc523424f6b82c::m639ee5b1a37fbe8ec5ce4b37 {
    public(friend) fun f83710a48ead5a4e120fe2888<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 <= 18446744073709551615 - arg2, 1);
        assert!(0x2::coin::value<T0>(&arg0) >= arg1 + arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public(friend) fun ffc7bc1eb5427171f5f8ae6e4(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) <= arg1, 0);
    }

    // decompiled from Move bytecode v7
}

