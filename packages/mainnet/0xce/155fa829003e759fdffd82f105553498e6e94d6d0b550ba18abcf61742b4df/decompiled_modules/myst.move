module 0xce155fa829003e759fdffd82f105553498e6e94d6d0b550ba18abcf61742b4df::myst {
    struct MYST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYST>(arg0, 6, b"MYST", b"Myst Privacy", b"Empowering Privacy with The Precision Of AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734763941495.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

