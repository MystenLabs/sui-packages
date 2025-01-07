module 0x337b8b8c442b1424e5e3d0fdc1abb3acb63eeeae52b70fbb259ebfc86d5db3e6::poppy {
    struct POPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPPY>(arg0, 6, b"POPPY", b"POPPY THE SEA LION", b"POPPY The most adorable sea lion in crypto, making waves in the SUI ocean!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/POPPY_BUY_GIF_813c06cc7e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

