module 0x2b98b0193c200ca23f07c19729a062821e25d03dc2ee348b6cabe76d10b16cd6::poke {
    struct POKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKE>(arg0, 6, b"POKE", b"Poke Verse", x"54686520466972737420506f6bc3a96d6f6e2d496e737069726564204d656d657665727365206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiahhwfzsb2qrs3rukv7vy7g6ywc6u76nmvbpysrd7v2d76bd4cct4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

