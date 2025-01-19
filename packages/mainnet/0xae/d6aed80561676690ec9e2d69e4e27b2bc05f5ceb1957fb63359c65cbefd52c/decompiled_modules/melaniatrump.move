module 0xaed6aed80561676690ec9e2d69e4e27b2bc05f5ceb1957fb63359c65cbefd52c::melaniatrump {
    struct MELANIATRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIATRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MELANIATRUMP>(arg0, 6, b"MELANIATRUMP", b"UnOfficial Melania Trump Coin by SuiAI", b"UnOfficial Melania Trump Coin for those who missed the Real Melania ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_19_234322_162ce49964.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MELANIATRUMP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIATRUMP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

