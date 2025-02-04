module 0x1f48f1efb1dafc0ac42e1b7d008887438d92d67a1f92bc92f4bd6fcc46425531::matrix_oracle {
    struct MATRIX_ORACLE has drop {
        dummy_field: bool,
    }

    public entry fun burn_coin(arg0: &mut 0x2::coin::TreasuryCap<MATRIX_ORACLE>, arg1: 0x2::coin::Coin<MATRIX_ORACLE>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<MATRIX_ORACLE>(arg0, arg1);
    }

    public fun init_matrix_oracle(arg0: MATRIX_ORACLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATRIX_ORACLE>(arg0, 9, b"MTO", b"Matrix Oracle", b"Matrix Oracle is the native coin for the Matrix Oracle ecosystem.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MATRIX_ORACLE>>(v1);
        0x2::coin::mint_and_transfer<MATRIX_ORACLE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATRIX_ORACLE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

