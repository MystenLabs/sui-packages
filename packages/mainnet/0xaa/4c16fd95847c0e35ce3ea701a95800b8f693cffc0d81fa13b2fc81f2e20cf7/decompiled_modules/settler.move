module 0xaa4c16fd95847c0e35ce3ea701a95800b8f693cffc0d81fa13b2fc81f2e20cf7::settler {
    public fun check_tolerance<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) + arg2 >= arg1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

