module 0xa96f68ce9b9c2cdb96224f5c04c4f4784d8b7b3e3a2a6cc9767a75daf32a5bf::soraai {
    struct SORAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SORAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SORAAI>(arg0, 6, b"SORAAI", b"Sora AI  by SuiAI", b"Sora AI could refer to a specific AI technology, product, or platform, depending on the context. Here are some possible interpretations:", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_1893_cddc555cd3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SORAAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SORAAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

