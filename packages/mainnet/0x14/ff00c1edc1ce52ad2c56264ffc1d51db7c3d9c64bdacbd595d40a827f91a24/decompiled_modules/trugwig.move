module 0x14ff00c1edc1ce52ad2c56264ffc1d51db7c3d9c64bdacbd595d40a827f91a24::trugwig {
    struct TRUGWIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUGWIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUGWIG>(arg0, 6, b"Trugwig", b"Trugwig Sui", x"5475727477696720697320612047726173732d7479706520506f6bc3a96d6f6e20696e74726f647563656420696e2047656e65726174696f6e2049562c207265636f676e697a6564206173207468652054696e79204c65616620506f6bc3a96d6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibene56kollwueqxifonu7hxjbdgokmto2ndmsuenbfc5cbfnqr2u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUGWIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUGWIG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

