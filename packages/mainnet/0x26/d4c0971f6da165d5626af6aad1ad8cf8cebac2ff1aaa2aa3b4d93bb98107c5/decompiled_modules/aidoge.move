module 0x26d4c0971f6da165d5626af6aad1ad8cf8cebac2ff1aaa2aa3b4d93bb98107c5::aidoge {
    struct AIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIDOGE>(arg0, 6, b"AIDOGE", b"AiDoge", b"The smarter, funnier, and friendlier Al-powered Doge!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731517699789.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

