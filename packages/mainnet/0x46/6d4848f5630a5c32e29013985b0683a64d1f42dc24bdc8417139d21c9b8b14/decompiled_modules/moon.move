module 0x466d4848f5630a5c32e29013985b0683a64d1f42dc24bdc8417139d21c9b8b14::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MOON>(arg0, 6, b"MOON", b"Moon Light", b"Moon light illuminates all living things.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000032546_d8bc364411.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

