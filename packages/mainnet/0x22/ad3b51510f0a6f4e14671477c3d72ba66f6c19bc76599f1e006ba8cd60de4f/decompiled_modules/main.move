module 0x22ad3b51510f0a6f4e14671477c3d72ba66f6c19bc76599f1e006ba8cd60de4f::main {
    public entry fun transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

