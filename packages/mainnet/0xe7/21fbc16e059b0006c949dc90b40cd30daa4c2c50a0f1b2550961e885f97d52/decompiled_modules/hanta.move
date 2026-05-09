module 0xe721fbc16e059b0006c949dc90b40cd30daa4c2c50a0f1b2550961e885f97d52::hanta {
    struct HANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANTA>(arg0, 6, b"Hanta", b"HATAVIRUS", b"Meme coin to follow the Hanatvirus trend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifjiqq5rds4acacp2w37bafmte2ognxrjda3zc4fjsjn53z4q7pti")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HANTA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

