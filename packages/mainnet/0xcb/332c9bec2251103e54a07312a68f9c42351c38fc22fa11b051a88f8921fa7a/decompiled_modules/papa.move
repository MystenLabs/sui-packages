module 0xcb332c9bec2251103e54a07312a68f9c42351c38fc22fa11b051a88f8921fa7a::papa {
    struct PAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPA>(arg0, 9, b"papa", b"papa", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAPA>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPA>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

