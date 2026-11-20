module 0x71302c47ff135676d661a37fac74806589ff6d1dd97f3d6113c1ae24ea2cdba0::m472d5a575de1939ea6bb60d7 {
    public(friend) fun f27d4a1b3f9a59cdd58099784(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) <= arg1, 0);
    }

    public(friend) fun f5180b527b4fffc6b85f1018f<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 <= 18446744073709551615 - arg2, 1);
        assert!(0x2::coin::value<T0>(&arg0) >= arg1 + arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

