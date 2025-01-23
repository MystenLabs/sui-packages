module 0x23ad838c340c2afc6a66b60bbd21964e9b85da15f0cba998eb65a58be22efbd2::closedloop_token {
    public fun transfer_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(0x2::coin::balance<T0>(arg0)) >= arg2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg2, arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

