module 0x3ab35bb72d7b8b1fb9e36169bab376a3dfb2ec319abfe84c8d88abf50fe8b0d2::test_contract_transfer {
    public entry fun withdraw<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

