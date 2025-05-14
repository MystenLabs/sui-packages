module 0xbc5061c4d6fd16445ce9f04bc583e70844824ec5bee94c0167521d18edd6dea::moat {
    struct MOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOAT>(arg0, 6, b"MOAT", b"Moat The Goat", b"Moat is a community-powered memecoin built on trust, culture, and the belief that crypto should be fun again. No empty promises, no complex narratives just a token that reflects the strength of its community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifrhnomoq5aciek4wo5ownv46qq4tk4qjqje2ljjtzuyhprxs5u7m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

