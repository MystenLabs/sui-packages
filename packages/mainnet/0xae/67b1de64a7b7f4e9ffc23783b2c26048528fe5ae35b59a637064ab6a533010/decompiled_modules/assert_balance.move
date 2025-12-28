module 0x21d47d630db3409a10dd96b0567e5867c508fc0e87e1403d39c5d064df17236c::assert_balance {
    public fun assert_balance<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 1);
        arg0
    }

    // decompiled from Move bytecode v6
}

