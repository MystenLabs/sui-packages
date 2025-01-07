module 0x68baf027b2e8233a0f445aaac6a756f034b657088f90f66342ac1eebae7e56c3::poke {
    struct POKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKE>(arg0, 6, b"Poke", b"Pokemon", x"0a506f6b656d6f6e20696e20746865207265616c20776f726c6421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pokemon_c724235c51.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

