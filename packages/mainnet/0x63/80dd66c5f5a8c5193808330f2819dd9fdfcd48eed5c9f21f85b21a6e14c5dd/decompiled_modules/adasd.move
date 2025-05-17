module 0x6380dd66c5f5a8c5193808330f2819dd9fdfcd48eed5c9f21f85b21a6e14c5dd::adasd {
    struct ADASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADASD>(arg0, 6, b"ADasd", b"aksjgdaskjdg", x"4d696e756e20697320616e20456c6563747269632d7479706520506f6bc3a96d6f6e20696e74726f647563656420696e2047656e65726174696f6e204949492c206f6674656e207265636f676e697a65642061732074686520224368656572696e6720506f6bc3a96d6f6e222e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeie4ri55sqnrwgnf2idhegdt3l6pfhfslryomg3afriypxrkdhe6fy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADASD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADASD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

