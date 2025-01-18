module 0x73df029bb74e2510a331286c26ed9fa56c99d991599a84c4d879e8d5e3fdbe5::ada {
    struct ADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ADA>(arg0, 6, b"ADA", b"Ada Shark by SuiAI", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images9_bccf491ac2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

