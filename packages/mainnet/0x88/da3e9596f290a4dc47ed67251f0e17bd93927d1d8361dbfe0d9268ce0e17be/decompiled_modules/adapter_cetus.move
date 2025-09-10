module 0x88da3e9596f290a4dc47ed67251f0e17bd93927d1d8361dbfe0d9268ce0e17be::adapter_cetus {
    public fun swap_base_to_quote<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public fun swap_quote_to_base<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

