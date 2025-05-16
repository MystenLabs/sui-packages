module 0x175c9e9657834b0dd73d0461a0c84dc65e669d58b6ec63eb66df62a6107633b8::horsea {
    struct HORSEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORSEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORSEA>(arg0, 6, b"HORSEA", b"HorseaSui", x"486f727365612069732061205761746572207479706520506f6bc3a96d6f6e20696e74726f647563656420696e2047656e65726174696f6e2031", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicql76ysyzdymyn64zjo6jrxelfgmvierwtbd3c5irbqdlcrhr2cu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORSEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HORSEA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

