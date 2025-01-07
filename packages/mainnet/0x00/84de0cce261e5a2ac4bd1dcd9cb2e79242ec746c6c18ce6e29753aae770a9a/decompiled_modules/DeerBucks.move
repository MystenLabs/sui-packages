module 0x84de0cce261e5a2ac4bd1dcd9cb2e79242ec746c6c18ce6e29753aae770a9a::DeerBucks {
    public fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::mint<T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

