module 0xec2c12c654c47f47da8de2d3b1befb99525e60a10f4ff2fdce18996cbc2aa784::misu {
    struct MISU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISU>(arg0, 6, b"Misu", b"MISUI", x"4d696e756e20697320616e20456c6563747269632d7479706520506f6bc3a96d6f6e20696e74726f647563656420696e2047656e65726174696f6e204949492c206f6674656e207265636f676e697a65642061732074686520224368656572696e6720506f6bc3a96d6f6e222e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid2gghzvjvpqneozo3e2eytqbsm7ap2ukut7lywfkgznlit4ker7q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MISU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

