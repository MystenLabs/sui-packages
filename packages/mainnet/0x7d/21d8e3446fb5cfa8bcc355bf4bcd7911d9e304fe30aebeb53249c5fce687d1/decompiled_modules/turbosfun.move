module 0x7d21d8e3446fb5cfa8bcc355bf4bcd7911d9e304fe30aebeb53249c5fce687d1::turbosfun {
    struct TURBOSFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOSFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOSFUN>(arg0, 6, b"Turbosfun", b"Turbos", b"Turbos is not fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732068113921.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOSFUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOSFUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

