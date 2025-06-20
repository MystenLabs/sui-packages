module 0x489714f2436e4c0302b44831c2c7b8a16016b1ebec7002a1c0bfbd7b44e1bf7a::labubus {
    struct LABUBUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABUBUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUBUS>(arg0, 6, b"LABUBUS", b"labubu", b"LABUBUS LABUBUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750401145387.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LABUBUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUBUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

