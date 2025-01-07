module 0x6e0ce7cd9e286eeae7dc1b2cfa94261bbff086ae6b2e357e31aa6bac7df00001::shbl {
    struct SHBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHBL>(arg0, 3, b"SHBL", b"Shoebill", b"The meme bird", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.jsdelivr.net/gh/leafwind/shoebill-coin/shoebill.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHBL>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHBL>>(v2, @0x6e91f4f0ed63d39d9bb697bb99e0c98cdcb8eac246c9b133fdb86a1445d5ac70);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

