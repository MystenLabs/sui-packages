module 0x8c3bc96c745abfe5964107213d53cdd8991f5f9c247c57102234b16fd6bc94f8::surb {
    struct SURB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURB>(arg0, 6, b"SURB", b"Sui Orb", b"An on-chain spirit born on Sui, with a purpose that reveals itself only to the curious.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaugatdskg3uihi5cxmmtp56polunm7icq3bu6kt72lwda776uumm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SURB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

