module 0x2f1baccdb058a91ba05434ce995b664d1223ef936e5aa75a1a488cfa75d239eb::mint {
    public fun mint_and_send_funds<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::send_funds<T0>(0x2::coin::mint<T0>(arg0, arg1, arg3), arg2);
    }

    public fun mint_and_transfer<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

