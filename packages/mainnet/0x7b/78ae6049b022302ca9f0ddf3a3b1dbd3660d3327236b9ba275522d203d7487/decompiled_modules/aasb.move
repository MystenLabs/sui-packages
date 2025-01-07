module 0x7b78ae6049b022302ca9f0ddf3a3b1dbd3660d3327236b9ba275522d203d7487::aasb {
    struct AASB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AASB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AASB>(arg0, 6, b"AASB", b"aaa spongebob", b"Can't stop won't stop (thinking about Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0933_14bcc2d328.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AASB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AASB>>(v1);
    }

    // decompiled from Move bytecode v6
}

