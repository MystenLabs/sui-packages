module 0x650b674eaa80958da348f5336328bcfd2cb7610535b4dfc0b10e2aec99432732::poly {
    struct POLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLY>(arg0, 6, b"POLY", b"Poly", b"Welcome to Antarctica, Home of POLY the Polar Bear. The coldest meme on SUI. POLY is all about the strategic play, the calculated moves, and leaving his POLY footprint in the exciting world of crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Poly_Logo_c376100e55.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

