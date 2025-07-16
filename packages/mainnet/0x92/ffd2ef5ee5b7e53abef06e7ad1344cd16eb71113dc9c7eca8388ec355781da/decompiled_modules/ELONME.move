module 0x92ffd2ef5ee5b7e53abef06e7ad1344cd16eb71113dc9c7eca8388ec355781da::ELONME {
    struct ELONME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONME>(arg0, 6, b"Elon Anime", b"ELONME", b"Elon in his anime prime", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELONME>>(v1);
    }

    // decompiled from Move bytecode v6
}

