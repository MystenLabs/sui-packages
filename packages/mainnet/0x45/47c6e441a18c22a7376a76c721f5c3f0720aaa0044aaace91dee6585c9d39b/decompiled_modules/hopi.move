module 0x4547c6e441a18c22a7376a76c721f5c3f0720aaa0044aaace91dee6585c9d39b::hopi {
    struct HOPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPI>(arg0, 6, b"HOPI", b"Hoppi", b"Pumping Is My Hopi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hoppy_6fec9923cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

