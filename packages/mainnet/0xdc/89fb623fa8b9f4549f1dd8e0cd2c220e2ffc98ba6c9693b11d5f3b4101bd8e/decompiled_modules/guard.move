module 0xdc89fb623fa8b9f4549f1dd8e0cd2c220e2ffc98ba6c9693b11d5f3b4101bd8e::guard {
    struct ArbExecuted<phantom T0> has copy, drop, store {
        sender: address,
        input_amount: u64,
        repay_amount: u64,
        profit: u64,
        hops: u8,
    }

    public fun profit_or_abort<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::coin::Coin<T0>) {
        assert!(arg1 > 0, 2);
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(v0 >= arg1, 0);
        let v1 = v0 - arg1;
        assert!(v1 >= arg2, 1);
        let v2 = ArbExecuted<T0>{
            sender       : 0x2::tx_context::sender(arg4),
            input_amount : v0,
            repay_amount : arg1,
            profit       : v1,
            hops         : arg3,
        };
        0x2::event::emit<ArbExecuted<T0>>(v2);
        (0x2::balance::split<T0>(&mut arg0, arg1), 0x2::coin::from_balance<T0>(arg0, arg4))
    }

    public fun profit_or_abort_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::coin::Coin<T0>) {
        profit_or_abort<T0>(0x2::coin::into_balance<T0>(arg0), arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

