module 0xf8568c6fe97e39af83d3c77f68b5526c771037ece1e07ac6c1649eabe53a7093::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 8, b"PUMP", b"Wrapped PUMP", b"ZO Finance Virtual Coin for PUMP", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUMP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PUMP>>(v0);
    }

    // decompiled from Move bytecode v7
}

