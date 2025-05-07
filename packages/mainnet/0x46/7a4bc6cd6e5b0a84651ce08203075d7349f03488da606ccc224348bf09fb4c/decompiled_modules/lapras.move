module 0x467a4bc6cd6e5b0a84651ce08203075d7349f03488da606ccc224348bf09fb4c::lapras {
    struct LAPRAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAPRAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAPRAS>(arg0, 6, b"LAPRAS", b"Lapras on Sui", b"Lapras is a meme-powered battlesea built on the fast, secure, and low-cost Sui blockchain. Users submit their favorite memes, vote with Lapras tokens, and decide which ones float to sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie5k6cgu7wsawcrhvigbvdgi7p72dxidv2cnksqfklvoiwhaqfa7e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAPRAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LAPRAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

