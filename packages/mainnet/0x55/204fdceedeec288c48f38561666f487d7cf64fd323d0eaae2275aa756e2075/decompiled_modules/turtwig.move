module 0x55204fdceedeec288c48f38561666f487d7cf64fd323d0eaae2275aa756e2075::turtwig {
    struct TURTWIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTWIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTWIG>(arg0, 6, b"Turtwig", b"Turtwig Sui", x"5475727477696720697320612047726173732d7479706520506f6bc3a96d6f6e20696e74726f647563656420696e2047656e65726174696f6e2049562c207265636f676e697a6564206173207468652054696e79204c65616620506f6b656d6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibene56kollwueqxifonu7hxjbdgokmto2ndmsuenbfc5cbfnqr2u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTWIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TURTWIG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

