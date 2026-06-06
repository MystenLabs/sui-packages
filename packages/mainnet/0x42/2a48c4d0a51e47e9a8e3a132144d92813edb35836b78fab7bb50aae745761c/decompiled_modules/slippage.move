module 0x422a48c4d0a51e47e9a8e3a132144d92813edb35836b78fab7bb50aae745761c::slippage {
    public fun verify<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 42);
    }

    // decompiled from Move bytecode v7
}

