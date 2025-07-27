module 0xb9603b3116b18afeb77b93844d40e9f0c49c9936a24be1c0d22b74461832cc25::ozzy {
    struct OZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OZZY>(arg0, 6, b"OZZY", b"The Crypto Prince of Darkness", b"A bold fusion of heavy metal iconography and blockchain rebellion, this artwork features Ozzy Osbourne throwing the legendary metal horns, mouth open mid-scream, channeling pure chaotic energy. Set against a gritty electric-blue background, Sui Network's logo glows from his pendant and rises behind him like a sacred sigil.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihm7rjnrsdmyvxzoixk3ed2bomn6ze3evoyloiqbpbmpe25oxniwe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OZZY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

