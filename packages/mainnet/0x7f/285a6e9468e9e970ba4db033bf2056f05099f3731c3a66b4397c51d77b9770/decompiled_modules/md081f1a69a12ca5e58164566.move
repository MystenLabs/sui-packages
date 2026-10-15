module 0x7f285a6e9468e9e970ba4db033bf2056f05099f3731c3a66b4397c51d77b9770::md081f1a69a12ca5e58164566 {
    public(friend) fun f6c47f31ef60e7a735d68e2d6<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 <= 18446744073709551615 - arg2, 1);
        assert!(0x2::coin::value<T0>(&arg0) >= arg1 + arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public(friend) fun f9499a9b2a674d493206dd967(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) <= arg1, 0);
    }

    // decompiled from Move bytecode v7
}

