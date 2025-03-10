module 0x3ddfcf2e7a25f53419444ece1faee75eb17c3fb4535d28063547bdf43553fcf9::snrkl {
    struct SNRKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNRKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNRKL>(arg0, 6, b"SNRKL", b"SNORKEL", x"546865206f726967696e616c206171756174696320656e69676d61202d20536e6f726b656c20697320746865206d6f73742069636f6e69632066697368206f6e2053554921205377696d20776974682024534e524b4c2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5705_d6654f29e3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNRKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNRKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

