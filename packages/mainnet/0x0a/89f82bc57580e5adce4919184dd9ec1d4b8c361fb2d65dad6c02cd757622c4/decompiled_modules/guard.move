module 0xa89f82bc57580e5adce4919184dd9ec1d4b8c361fb2d65dad6c02cd757622c4::guard {
    public fun assert_min_value<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 0);
        arg0
    }

    // decompiled from Move bytecode v7
}

