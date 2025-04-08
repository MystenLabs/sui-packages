module 0x5d46ec8c0db952054a7b5a3961501881f1f0fe1f9311134af682442b4209cb4c::closedloop_token {
    public fun transfer_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(0x2::coin::balance<T0>(arg0)) >= arg2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg2, arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

