module 0x923b79fc7d6c59d713528460e9cb0fdd8bae4def99ebd1c33a0b50415efa0e7f::test_contract_transfer {
    public entry fun withdraw<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

