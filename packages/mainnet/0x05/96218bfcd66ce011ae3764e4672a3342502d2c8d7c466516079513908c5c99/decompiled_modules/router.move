module 0x596218bfcd66ce011ae3764e4672a3342502d2c8d7c466516079513908c5c99::router {
    public fun settle<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::coin::Coin<T0>) {
        assert!(0x2::balance::value<T0>(&arg0) >= arg1 + arg2, 0);
        (0x2::balance::split<T0>(&mut arg0, arg1), 0x2::coin::from_balance<T0>(arg0, arg3))
    }

    public fun settle_with_profit<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::coin::Coin<T0>, u64) {
        let (v0, v1) = settle<T0>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        (v0, v2, 0x2::coin::value<T0>(&v2))
    }

    // decompiled from Move bytecode v7
}

