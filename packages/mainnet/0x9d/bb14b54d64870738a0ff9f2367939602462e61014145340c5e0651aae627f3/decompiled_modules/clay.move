module 0x9dbb14b54d64870738a0ff9f2367939602462e61014145340c5e0651aae627f3::clay {
    struct CLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAY>(arg0, 6, b"CLAY", b"Claynosaurz", b"Let your imagination Saur", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifjhjnt6mvceu2dknoyjmtbyez6gnizdyo55tr2jbzfpiipdrieje")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CLAY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

