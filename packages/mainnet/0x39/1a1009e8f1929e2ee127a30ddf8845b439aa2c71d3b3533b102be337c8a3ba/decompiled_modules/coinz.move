module 0x391a1009e8f1929e2ee127a30ddf8845b439aa2c71d3b3533b102be337c8a3ba::coinz {
    public fun zero<T0>(arg0: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::zero<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

