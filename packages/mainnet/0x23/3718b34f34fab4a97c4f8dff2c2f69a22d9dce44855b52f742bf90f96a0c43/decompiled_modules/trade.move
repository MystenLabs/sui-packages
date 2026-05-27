module 0x6f94c8d30ede49305742cc3e7f30289fa1f5d698425edb8e44062ae5b39717dd::trade {
    public fun check<T0>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg1) > arg0, 101);
        arg1
    }

    public fun check_and_split<T0>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg1) > arg0, 101);
        (0x2::coin::split<T0>(&mut arg1, arg0, arg2), arg1)
    }

    // decompiled from Move bytecode v7
}

