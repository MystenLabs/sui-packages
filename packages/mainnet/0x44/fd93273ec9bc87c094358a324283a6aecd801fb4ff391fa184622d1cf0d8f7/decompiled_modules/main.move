module 0x44fd93273ec9bc87c094358a324283a6aecd801fb4ff391fa184622d1cf0d8f7::main {
    entry fun transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

