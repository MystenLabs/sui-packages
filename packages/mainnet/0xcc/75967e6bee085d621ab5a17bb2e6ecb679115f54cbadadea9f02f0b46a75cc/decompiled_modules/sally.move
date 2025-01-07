module 0xcc75967e6bee085d621ab5a17bb2e6ecb679115f54cbadadea9f02f0b46a75cc::sally {
    struct SALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALLY>(arg0, 6, b"Sally", b"Sui Sally", x"53686527732074686520736d6f6f74682c20626c7565206265617574792066726f6d2043617273206e6f77206372756973696e67206f6e2074686520537569204e6574776f726b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sally_11344fb13a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

