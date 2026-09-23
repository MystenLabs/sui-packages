module 0x8a532b59f6f7976d5cf544f93c831abebd11a04ccdc8f8ae31b6d0be792f3137::settlement {
    public fun finish<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 0);
        send<T0>(arg0, arg2);
    }

    public fun send<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::coin::send_funds<T0>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v7
}

