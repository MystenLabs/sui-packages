module 0xbf8be835ac3b67ab7813d702dd13fc9438cd05ccca585bb9122f67e1e94c4ecc::koin {
    struct KOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOIN>(arg0, 6, b"Koin", b"Kyra", b"A visionary platform to explore and create dreams and hope, blending technology with imagination. Light up the future at your fingertips.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734778215308.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

