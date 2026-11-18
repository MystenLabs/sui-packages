module 0x6342a040c4b34d6c33fd43bd9775b16c7f8e04cda5b2571aacf32304d48f1ae6::arb_floor {
    public fun take<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!(v0 >= arg1, 0);
        assert!(v0 - arg1 >= arg2, 1);
        0x2::coin::split<T0>(arg0, arg1, arg3)
    }

    // decompiled from Move bytecode v7
}

