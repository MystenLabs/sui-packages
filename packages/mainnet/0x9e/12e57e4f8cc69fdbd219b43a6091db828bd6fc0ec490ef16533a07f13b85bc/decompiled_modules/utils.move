module 0x9e12e57e4f8cc69fdbd219b43a6091db828bd6fc0ec490ef16533a07f13b85bc::utils {
    public(friend) fun handle_payment<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 1);
        0x2::coin::put<T0>(arg0, 0x2::coin::split<T0>(&mut arg1, arg2, arg3));
        0x2::pay::keep<T0>(arg1, arg3);
    }

    public(friend) fun handle_transfer<T0>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 1);
        0x2::pay::split_and_transfer<T0>(&mut arg1, arg2, arg0, arg3);
        0x2::pay::keep<T0>(arg1, arg3);
    }

    public(friend) fun withdraw_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(arg0);
        assert!(v0 > 0, 0);
        0x2::pay::keep<T0>(0x2::coin::take<T0>(arg0, v0, arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

