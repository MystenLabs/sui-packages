module 0xe7c7d7620afad1aa3ff1191c8ace427ac5353e539ef4bcacebc804c1b73858cc::settlement {
    public fun assert_profit(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 >= arg1, 1);
        assert!(arg0 - arg1 >= arg2, 2);
    }

    public fun finish<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 3);
        send<T0>(arg0, arg2);
    }

    public fun send<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::coin::send_funds<T0>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun take_repayment<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_profit(0x2::coin::value<T0>(arg0), arg1, arg2);
        0x2::coin::split<T0>(arg0, arg1, arg3)
    }

    // decompiled from Move bytecode v7
}

