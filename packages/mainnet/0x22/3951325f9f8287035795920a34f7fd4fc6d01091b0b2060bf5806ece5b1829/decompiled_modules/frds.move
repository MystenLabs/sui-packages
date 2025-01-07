module 0x223951325f9f8287035795920a34f7fd4fc6d01091b0b2060bf5806ece5b1829::frds {
    struct FRDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRDS>(arg0, 9, b"FRDS", b"Friends", b"The ultimate and fiercest meme coin. The slayer of low-value meme coins.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FRDS>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRDS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

