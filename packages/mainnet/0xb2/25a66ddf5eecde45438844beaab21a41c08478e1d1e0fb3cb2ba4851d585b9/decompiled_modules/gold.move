module 0xb225a66ddf5eecde45438844beaab21a41c08478e1d1e0fb3cb2ba4851d585b9::gold {
    struct GOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLD>(arg0, 6, b"GOLD", b"Gold on Sui", x"24474f4c442069732061206d656d65636f696e206f6e2074686520537569206e6574776f726b2c20696e73706972656420627920706f70756c61722054656c656772616d20737469636b6572732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gold_on_Sui_ffac0be294.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

