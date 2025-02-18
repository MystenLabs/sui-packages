module 0x6740ced1f848cee0906d958f3a888ef4ad21dae0a69d8422f018eb229b502a58::utils {
    public entry fun checkSlippage<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    public fun splitCoin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg0) > arg1) {
            (0x2::coin::split<T0>(&mut arg0, arg1, arg2), arg0)
        } else {
            (arg0, 0x2::coin::zero<T0>(arg2))
        }
    }

    // decompiled from Move bytecode v6
}

