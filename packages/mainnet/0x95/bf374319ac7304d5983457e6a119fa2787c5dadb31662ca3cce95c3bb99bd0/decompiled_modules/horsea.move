module 0x95bf374319ac7304d5983457e6a119fa2787c5dadb31662ca3cce95c3bb99bd0::horsea {
    struct HORSEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORSEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORSEA>(arg0, 6, b"HORSEA", b"HORSEA SUI", x"486f727365612069732061205761746572207479706520506f6bc3a96d6f6e20696e74726f647563656420696e2047656e65726174696f6e20312e0a4e6f77206f6e205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidc63wumv4yvhqrbpu3q7x63u5ustyfdklrau5xubagpg3upbx2eu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORSEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HORSEA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

