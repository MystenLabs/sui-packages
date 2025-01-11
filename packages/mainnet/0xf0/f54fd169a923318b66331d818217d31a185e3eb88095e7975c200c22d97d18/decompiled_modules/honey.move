module 0xf0f54fd169a923318b66331d818217d31a185e3eb88095e7975c200c22d97d18::honey {
    struct HONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONEY>(arg0, 6, b"HONEY", b"Haney Baby", b"Welcome to Honey Baby, the kawaii-est currency in the metaverse! Combining the love for anime with the magic, we're here to win hearts and digital wallets alike.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_4f1b6d4250.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HONEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

