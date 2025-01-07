module 0xf4432b58edbf5907bde239eb03d5f54295d3bf0ebb9f6ca663d50b99af3c68d::rigged {
    struct RIGGED has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIGGED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIGGED>(arg0, 6, b"RIGGED", b"Rigged On sui", x"2452494747454420546865206d656d65636f696e0a746861742072756e732074686520776f726c64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002659_077422560e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIGGED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIGGED>>(v1);
    }

    // decompiled from Move bytecode v6
}

