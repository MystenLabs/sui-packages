module 0x9b4fc37ad2c56b619e50e6628fcef817f73f6b910d178bc86afc771a7a0d7fa9::sfai {
    struct SFAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SFAI>(arg0, 6, b"SFAI", b"Scarface AI by SuiAI", b"Be on top of the world like Tony Montana!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_3458_6a9949cc39.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SFAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

