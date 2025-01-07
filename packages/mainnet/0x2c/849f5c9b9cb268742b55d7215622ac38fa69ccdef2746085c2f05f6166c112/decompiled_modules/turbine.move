module 0x2c849f5c9b9cb268742b55d7215622ac38fa69ccdef2746085c2f05f6166c112::turbine {
    struct TURBINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBINE>(arg0, 6, b"TURBINE", b"Turbine", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954551531.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBINE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBINE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

