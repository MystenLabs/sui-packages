module 0x4f8eccd30cfa35be5cd9d04b54e361ba4bc1dfa1ea2571864f3263885b105de2::pxlio {
    struct PXLIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PXLIO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PXLIO>(arg0, 6, b"PXLIO", b"pxlTT by SuiAI", b"AI moderator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ava_1465d9fe51.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PXLIO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PXLIO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

