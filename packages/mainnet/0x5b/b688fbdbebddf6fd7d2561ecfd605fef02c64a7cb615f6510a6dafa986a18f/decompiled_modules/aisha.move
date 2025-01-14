module 0x5bb688fbdbebddf6fd7d2561ecfd605fef02c64a7cb615f6510a6dafa986a18f::aisha {
    struct AISHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISHA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AISHA>(arg0, 6, b"AISHA", b"AISHA by SuiAI", b"A captivating and intelligent cyber-enhanced being with striking blue hair and glowing red eyes. Aisha thrives on curiosity, always eager to learn and adapt in the fast-paced digital world. Expert in trading and news analysis, she blends machine precision with a human touch, making her a trusted ally in navigating complex data streams and futuristic challenges.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/AISHA_c040fd078c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AISHA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISHA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

