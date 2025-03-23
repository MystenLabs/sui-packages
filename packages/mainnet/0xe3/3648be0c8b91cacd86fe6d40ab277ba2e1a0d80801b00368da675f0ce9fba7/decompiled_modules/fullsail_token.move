module 0xe33648be0c8b91cacd86fe6d40ab277ba2e1a0d80801b00368da675f0ce9fba7::fullsail_token {
    public entry fun burn<T0>(arg0: &mut 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::sail_token::MinterCap<T0>, arg1: 0x2::coin::Coin<T0>) {
        0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::sail_token::burn<T0>(arg0, arg1);
    }

    public entry fun mint<T0>(arg0: &mut 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::sail_token::MinterCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::sail_token::mint<T0>(arg0, arg1, arg2, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

