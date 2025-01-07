module 0x89d78d114de6a52c793215e3364a53508e6d752bddf98a24f9e1432022c64b17::test_contract_transfer {
    public entry fun withdraw<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

