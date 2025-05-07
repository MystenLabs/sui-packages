module 0xd15d861c662909ee556f2a9e12dff0db3af0416d7faf4461f39e58d41ff269b9::chillec {
    struct CHILLEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLEC>(arg0, 6, b"CHILLEC", b"Chill Evan Cheng", b"Hold $CHILLEC and chill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidhvmmqy3grg5o624laksi36w2fmx7kqr4mapnmespb5xl6qrltam")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLEC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHILLEC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

