module 0x5852b8c9cd3563d1990b2c583c426a7a308d44af8744515d3d87890883ad12f8::rtmlp {
    struct RTMLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTMLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTMLP>(arg0, 6, b"RTMLP", b"RETIREMENT BASKET", b"Group of most hyped coins of 2026", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RTMLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTMLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

