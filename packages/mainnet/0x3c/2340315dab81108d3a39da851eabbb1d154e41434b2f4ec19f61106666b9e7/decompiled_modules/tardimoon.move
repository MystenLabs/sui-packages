module 0x3c2340315dab81108d3a39da851eabbb1d154e41434b2f4ec19f61106666b9e7::tardimoon {
    struct TARDIMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARDIMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARDIMOON>(arg0, 6, b"TARDIMOON", b"TARDIMOONSUI", b"Built to vibe and thrive. TARDI survives everything - bear markets, nuclear winter, you name it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibumhpw5yxbhutv6fkib233xspqd6ounxseqtro6gmrlk7d3yakde")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARDIMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TARDIMOON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

