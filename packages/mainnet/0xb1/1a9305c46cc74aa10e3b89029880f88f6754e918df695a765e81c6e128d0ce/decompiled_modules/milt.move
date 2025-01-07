module 0xb11a9305c46cc74aa10e3b89029880f88f6754e918df695a765e81c6e128d0ce::milt {
    struct MILT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILT>(arg0, 6, b"MILT", b"Milty", b"Milty is the stormproof meme coin, blowing through the crypto markets like Hurricane Milton! Inspired by the viral impact of natural events, Milty represents the strength, unpredictability, and wild energy of both nature and the crypto space. Just like a hurricane gaining strength as it approaches land, Milty is designed to gain momentum as the market surges. Built to withstand volatility, this token is all about riding out the waves and coming out stronger on the other side. Whether you're braving the crypto storm or looking for the next big windfall, Milty is here to blow expectations away!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Milty_3221e89bbd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILT>>(v1);
    }

    // decompiled from Move bytecode v6
}

