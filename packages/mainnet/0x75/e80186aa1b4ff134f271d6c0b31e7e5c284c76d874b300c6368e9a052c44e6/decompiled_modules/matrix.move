module 0x75e80186aa1b4ff134f271d6c0b31e7e5c284c76d874b300c6368e9a052c44e6::matrix {
    struct MATRIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATRIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATRIX>(arg0, 6, b"MATRIX", b"THEMATRIX", b"#", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733532325425.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MATRIX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATRIX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

