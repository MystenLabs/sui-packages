module 0xd5471c69c4044e1b1c517d71de2f1066ce32aea851874aa426df30c7bd4d5036::dwog {
    struct DWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWOG>(arg0, 6, b"DWOG", b"dwog", b"Only Dwog in the Fwog world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730981788747.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DWOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

