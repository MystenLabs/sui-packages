module 0xe4a7b2bd83c01bef7969eccb9909a03daa401ea731546b92be4e4e751687d918::coinz {
    public fun zero<T0>(arg0: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::zero<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

