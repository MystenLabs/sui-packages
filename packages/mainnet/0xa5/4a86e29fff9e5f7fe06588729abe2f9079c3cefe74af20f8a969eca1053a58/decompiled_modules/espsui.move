module 0xa54a86e29fff9e5f7fe06588729abe2f9079c3cefe74af20f8a969eca1053a58::espsui {
    struct ESPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESPSUI>(arg0, 6, b"ESPSUI", b"Espsui Pokemon Adventure", b"$ESPSUI build an innovative gaming experience that merges classic Pokemon gameplay with blockchain technology on the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiahw7ame7cke7ekrtt2czhtvjua5p3k2q3th7b5aayqgjxbpqfhri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ESPSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

