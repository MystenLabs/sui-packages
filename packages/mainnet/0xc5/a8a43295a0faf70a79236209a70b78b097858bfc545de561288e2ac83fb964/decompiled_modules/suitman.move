module 0xc5a8a43295a0faf70a79236209a70b78b097858bfc545de561288e2ac83fb964::suitman {
    struct SUITMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITMAN>(arg0, 6, b"SUITMAN", b"SUITAMAN", b"One punch, one pump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigk7ax57pqbptg7cs54w75rtsxcbahf2kbku4wlsdlpqezqhwrlr4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITMAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

