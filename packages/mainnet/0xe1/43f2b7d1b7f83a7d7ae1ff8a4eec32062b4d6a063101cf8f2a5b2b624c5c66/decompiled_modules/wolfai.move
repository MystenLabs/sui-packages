module 0xe143f2b7d1b7f83a7d7ae1ff8a4eec32062b4d6a063101cf8f2a5b2b624c5c66::wolfai {
    struct WOLFAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLFAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WOLFAI>(arg0, 6, b"WOLFAI", b"WOLFAI ON SUAI by SuiAI", b"Welcome to the Suai Wolf Pack!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_5_2025_02_23_16_51_03_5001df7c0e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOLFAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLFAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

