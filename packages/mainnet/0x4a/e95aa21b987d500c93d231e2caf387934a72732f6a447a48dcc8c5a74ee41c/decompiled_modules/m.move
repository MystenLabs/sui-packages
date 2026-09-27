module 0x4ae95aa21b987d500c93d231e2caf387934a72732f6a447a48dcc8c5a74ee41c::m {
    public fun gz<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg0) >= arg1, 100);
        0x2::coin::from_balance<T0>(arg0, arg2)
    }

    // decompiled from Move bytecode v7
}

