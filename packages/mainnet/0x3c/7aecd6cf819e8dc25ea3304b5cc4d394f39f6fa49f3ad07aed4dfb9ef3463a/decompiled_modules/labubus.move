module 0x3c7aecd6cf819e8dc25ea3304b5cc4d394f39f6fa49f3ad07aed4dfb9ef3463a::labubus {
    struct LABUBUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABUBUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUBUS>(arg0, 6, b"LABUBUS", b"labubu", b"LABUBUS LABUBUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750389788356.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LABUBUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUBUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

