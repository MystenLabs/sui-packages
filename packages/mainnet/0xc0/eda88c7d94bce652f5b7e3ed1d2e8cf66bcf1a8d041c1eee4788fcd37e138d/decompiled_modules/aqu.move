module 0xc0eda88c7d94bce652f5b7e3ed1d2e8cf66bcf1a8d041c1eee4788fcd37e138d::aqu {
    struct AQU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQU>(arg0, 6, b"AQU", b"AQU SUI", b"AQU is suinami on sui chain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x6500197a2488610aca288fd8e2dfe88ec99e596c_417c54a924.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQU>>(v1);
    }

    // decompiled from Move bytecode v6
}

