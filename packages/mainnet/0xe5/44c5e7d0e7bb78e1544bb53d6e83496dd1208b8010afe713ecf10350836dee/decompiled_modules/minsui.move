module 0xe544c5e7d0e7bb78e1544bb53d6e83496dd1208b8010afe713ecf10350836dee::minsui {
    struct MINSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINSUI>(arg0, 6, b"MINSUI", b"MINSUII", x"4d696e756e20697320616e20456c6563747269632d7479706520506f6bc3a96d6f6e20696e74726f647563656420696e2047656e65726174696f6e204949492c206f6674656e207265636f676e697a656420617320746865204368656572696e6720506f6bc3a96d6f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiawy5kuv4awxvxyyqswyxpdemlz7m4jguyz2jpjf7yroqq6rsiyde")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MINSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

