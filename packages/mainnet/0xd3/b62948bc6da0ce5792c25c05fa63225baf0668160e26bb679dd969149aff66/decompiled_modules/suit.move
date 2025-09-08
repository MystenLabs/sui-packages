module 0xd3b62948bc6da0ce5792c25c05fa63225baf0668160e26bb679dd969149aff66::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 6, b"Suit", b"HazmatSuit", b"SUIT is Sui hazmat meme community-driven protective positivity that contains FUD, amplifies fun, and turns degen lab energy into culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie3zkdxoe3244x65ches5l55zysgc3rhyamzxhxcjavfpgmcaycaq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

