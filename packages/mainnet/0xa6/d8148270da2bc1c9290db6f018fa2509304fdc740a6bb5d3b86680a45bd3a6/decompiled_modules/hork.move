module 0xa6d8148270da2bc1c9290db6f018fa2509304fdc740a6bb5d3b86680a45bd3a6::hork {
    struct HORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORK>(arg0, 6, b"HORK", b"half horse half shark", b"HORK is two very different animals fused into one  each with its own unique and distinctive personality. What makes it special It a freshly born meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiel3ud4bjf4uvndhlspoedhcwtb35f6vi45uz2rjvszyj5nhnsiry")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HORK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

