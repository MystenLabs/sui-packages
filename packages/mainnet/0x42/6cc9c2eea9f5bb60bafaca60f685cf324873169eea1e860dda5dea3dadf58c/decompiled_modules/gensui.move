module 0x426cc9c2eea9f5bb60bafaca60f685cf324873169eea1e860dda5dea3dadf58c::gensui {
    struct GENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENSUI>(arg0, 6, b"GENSUI", b"Gengar on Sui", b"Gensui is the first meme Pokemon gamble game built on Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiasi5kvg7unq35zod3ksdjlr6cneciy5jy3cbpxxpwqauqgefkxei")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GENSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

