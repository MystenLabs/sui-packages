module 0x496b3c891e3c4272518d98896ed578741c67a2540e99653e42597f7a160e7c8a::profit_checker {
    public fun assert_profit<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    // decompiled from Move bytecode v6
}

