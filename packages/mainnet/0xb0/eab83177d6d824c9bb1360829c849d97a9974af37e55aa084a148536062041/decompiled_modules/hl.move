module 0xb0eab83177d6d824c9bb1360829c849d97a9974af37e55aa084a148536062041::hl {
    struct HL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HL>(arg0, 6, b"HL", b"xhlq", b"not", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_2_0988353340.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

