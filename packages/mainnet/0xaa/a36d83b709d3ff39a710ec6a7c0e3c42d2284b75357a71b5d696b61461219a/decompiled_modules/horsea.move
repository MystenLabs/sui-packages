module 0xaaa36d83b709d3ff39a710ec6a7c0e3c42d2284b75357a71b5d696b61461219a::horsea {
    struct HORSEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORSEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORSEA>(arg0, 6, b"HORSEA", b"HorseaSui", x"486f727365612069732061205761746572207479706520506f6bc3a96d6f6e20696e74726f647563656420696e2047656e65726174696f6e2031", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihem6b4zawthnt36ir7jitkwsfbnjz7plgrxba6dm6ndxlgcqky3q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORSEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HORSEA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

