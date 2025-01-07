module 0x16cae33b71405a0f6b193f2b60b54c9fafb26d79dbc2a63b168d265dbc147a30::arcane {
    struct ARCANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARCANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARCANE>(arg0, 6, b"Arcane", b"Arcane coin", b"Streaming coin utility ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241124_114634_b563481a9b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARCANE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARCANE>>(v1);
    }

    // decompiled from Move bytecode v6
}

