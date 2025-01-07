module 0x8d4db6b7d0ff207ae7e7748c62e60b4796ff9c9771cb477a666450aa2bb5c9bf::DeerBucks {
    public fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::mint<T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

