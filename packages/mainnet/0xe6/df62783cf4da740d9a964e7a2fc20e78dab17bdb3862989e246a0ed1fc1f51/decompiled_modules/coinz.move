module 0xe6df62783cf4da740d9a964e7a2fc20e78dab17bdb3862989e246a0ed1fc1f51::coinz {
    public fun zero<T0>(arg0: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::zero<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

