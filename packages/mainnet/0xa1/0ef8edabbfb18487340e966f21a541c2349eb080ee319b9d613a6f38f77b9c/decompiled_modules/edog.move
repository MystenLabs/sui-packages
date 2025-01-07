module 0xa10ef8edabbfb18487340e966f21a541c2349eb080ee319b9d613a6f38f77b9c::edog {
    struct EDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDOG>(arg0, 6, b"EDOG", b"Eagle Dog", x"2254686579207265616c6c79206d61646520616e206561676c6520616e64206120646f6720696e746f206f6e652e2057696c642e2220e2809320456c6f6e204d75736b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732200958276.42")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

