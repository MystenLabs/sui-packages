module 0xd1f77a2d5751d990b41e0e04186df159305b55deb78d2b0b4c5ced44d17bc111::turboodeng {
    struct TURBOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOODENG>(arg0, 6, b"TURBOODENG", b"TURBOODENG ", b"TURBOODENG POWERED BY SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958349185.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOODENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOODENG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

