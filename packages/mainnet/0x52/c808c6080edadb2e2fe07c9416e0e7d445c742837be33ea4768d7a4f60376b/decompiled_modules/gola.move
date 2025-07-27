module 0x52c808c6080edadb2e2fe07c9416e0e7d445c742837be33ea4768d7a4f60376b::gola {
    struct GOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLA>(arg0, 6, b"GOLA", b"GoonLand", b"Where the goons stack bags, hatch SUI dreams, and vibe like its always pump a clock. No suits, just memes, tokens, and pure degen energy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiekxem57reolx7yp2grvu5d7g2ydfbjl6vq7ulfa6bznycydxwcpe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOLA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

