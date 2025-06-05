module 0x7bd95821ab10303331fa053c47eec27cf20c7f24f64a1b9169ee36058d6816c2::nothing {
    struct NOTHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTHING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTHING>(arg0, 6, b"NOTHING", b"This is nothing", b"You're buying nothing, forreal you're buying nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigdaopaqu6yshv4mqz2yserrfx6wfvtiv5tjpxjvd7gbg4sxlr2ba")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTHING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOTHING>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

