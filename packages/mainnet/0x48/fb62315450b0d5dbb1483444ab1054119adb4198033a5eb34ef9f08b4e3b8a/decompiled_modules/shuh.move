module 0x48fb62315450b0d5dbb1483444ab1054119adb4198033a5eb34ef9f08b4e3b8a::shuh {
    struct SHUH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUH>(arg0, 6, b"SHUH", b"Sui HUH", b"Just a huh cat in sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HUH_cac5f3a5c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUH>>(v1);
    }

    // decompiled from Move bytecode v6
}

