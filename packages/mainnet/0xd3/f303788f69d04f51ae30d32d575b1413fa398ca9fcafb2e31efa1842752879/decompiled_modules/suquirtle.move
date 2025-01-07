module 0xd3f303788f69d04f51ae30d32d575b1413fa398ca9fcafb2e31efa1842752879::suquirtle {
    struct SUQUIRTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUQUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUQUIRTLE>(arg0, 6, b"SUQUIRTLE", b"SuQuirtle on Sui", x"537571756972746c652069732061206e6f7374616c67696120636f6d6d756e6974792d64726976656e206d656d652064657369676e656420746f20696e6a6563742068756d6f7220616e642063726561746976697479206f6e2074686520537569204e6574776f726b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_a66e81b4e4_3081ca9916.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUQUIRTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUQUIRTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

