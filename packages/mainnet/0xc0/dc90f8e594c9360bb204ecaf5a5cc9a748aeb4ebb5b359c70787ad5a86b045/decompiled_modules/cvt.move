module 0xc0dc90f8e594c9360bb204ecaf5a5cc9a748aeb4ebb5b359c70787ad5a86b045::cvt {
    public fun b2c<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun c2b<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

