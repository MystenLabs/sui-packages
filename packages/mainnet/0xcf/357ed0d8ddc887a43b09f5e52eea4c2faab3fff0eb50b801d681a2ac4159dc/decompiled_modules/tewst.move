module 0xcf357ed0d8ddc887a43b09f5e52eea4c2faab3fff0eb50b801d681a2ac4159dc::tewst {
    struct TEWST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEWST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEWST>(arg0, 6, b"TEWST", b"test`", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732536951067.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEWST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEWST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

