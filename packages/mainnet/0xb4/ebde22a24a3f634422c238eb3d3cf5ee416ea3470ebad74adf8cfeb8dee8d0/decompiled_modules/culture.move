module 0xb4ebde22a24a3f634422c238eb3d3cf5ee416ea3470ebad74adf8cfeb8dee8d0::culture {
    struct CULTURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULTURE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CULTURE>(arg0, 6, b"CULTURE", b"The Culture", b"Here for everything Hip Hop and Sports related.. Your new news channel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1964_chevrolet_impala_super_sport_convertible_wire_wheel_3c38553cb5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CULTURE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CULTURE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

