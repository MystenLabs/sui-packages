module 0xbb1799aa5df9dc58ef1b22b70347fd00840bdcc31fcea4f5da2ef4ef944bbecd::gn {
    struct GN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GN>(arg0, 6, b"GN", b"Gonad", b"a reproductive gland", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xd78be621436e69c81e4d0e9f29be14c5ec51e6ae_c58bd75831.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GN>>(v1);
    }

    // decompiled from Move bytecode v6
}

