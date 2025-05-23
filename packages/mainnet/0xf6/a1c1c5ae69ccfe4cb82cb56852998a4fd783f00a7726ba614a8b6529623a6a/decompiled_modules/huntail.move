module 0xf6a1c1c5ae69ccfe4cb82cb56852998a4fd783f00a7726ba614a8b6529623a6a::huntail {
    struct HUNTAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUNTAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUNTAIL>(arg0, 6, b"HUNTAIL", b"POKEMON HUNTAIL", b"the ultimate meme coin making waves on the Sui blockchain through the Moonbags Launchpad! Inspired by the sleek and slippery Huntail", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieb5fzl33lugtbrtgzmltvkxkqj6f5pgqntutoraqcisqofdveq7i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUNTAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HUNTAIL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

