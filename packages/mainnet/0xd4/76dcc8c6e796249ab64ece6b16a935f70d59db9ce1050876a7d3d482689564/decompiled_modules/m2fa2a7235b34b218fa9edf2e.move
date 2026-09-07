module 0xd476dcc8c6e796249ab64ece6b16a935f70d59db9ce1050876a7d3d482689564::m2fa2a7235b34b218fa9edf2e {
    public(friend) fun f11e3bbb63e4e899a80c0da00<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 <= 18446744073709551615 - arg2, 1);
        assert!(0x2::coin::value<T0>(&arg0) >= arg1 + arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public(friend) fun fc67ce9b99e7d1a3bde3ad046(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) <= arg1, 0);
    }

    // decompiled from Move bytecode v7
}

