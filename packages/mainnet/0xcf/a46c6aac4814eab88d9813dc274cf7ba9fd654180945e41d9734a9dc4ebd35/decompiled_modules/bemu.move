module 0xcfa46c6aac4814eab88d9813dc274cf7ba9fd654180945e41d9734a9dc4ebd35::bemu {
    struct BEMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEMU>(arg0, 6, b"BEMU", b"Bemu Sui", b"$BEMU is described as more than just another cryptocurrency; it's a narrative-driven project that integrates community, virtual intelligence, and entertainment. It tells the story of a blue alien dreaming of a trip to Mars with Elon Musk's Starship, combining storytelling with tangible value through innovative tokenomics, NFT integration, and a play-to-earn (P2E) gaming ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidc2u24e5j4bbzwyi2f3xd3xxy4qhtuk7gbazsfouffcirrean54q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BEMU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

