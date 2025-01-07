module 0xcdfcff4800addb1d8a9fa87e60f56d717eb6e2d547d6c2cc5f95f28ce1ce2ccc::rupee {
    struct RUPEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUPEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUPEE>(arg0, 6, b"Rupee", b"Rupert", b"Hes cute as fuck ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732226364555.WEBP")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUPEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUPEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

