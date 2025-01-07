module 0x625f4650dd6b3dc4de731543f20d4f5f6798eeb702ce16b66e26d95a0f3f362::cz {
    struct CZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZ>(arg0, 6, b"CZ", b"SUIZEE", b"Cz token on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suizee_b8b9dcb86d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

