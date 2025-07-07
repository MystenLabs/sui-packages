module 0xe2e5948bce2b172d360315e1bb3b7e1b0d03f211b2f22922d7cdfd76efe35bd0::simple_donation {
    public entry fun donate_nft<T0: store + key>(arg0: T0, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(arg0, arg1);
    }

    public entry fun donate_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
    }

    public entry fun donate_token<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

