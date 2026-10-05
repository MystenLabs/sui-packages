module 0x59b9cae6b3b7615e61e0ec0b5782efbdacb57e694b6f43d90688ea35cd509dc2::jesus {
    struct JESUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUS>(arg0, 6, b"JESUS", b"ISSA THE SAVIOUR ", b"Holy Pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1791189805274.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JESUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

