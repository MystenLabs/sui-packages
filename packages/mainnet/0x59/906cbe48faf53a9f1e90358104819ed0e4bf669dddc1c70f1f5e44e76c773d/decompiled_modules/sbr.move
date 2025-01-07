module 0x59906cbe48faf53a9f1e90358104819ed0e4bf669dddc1c70f1f5e44e76c773d::sbr {
    struct SBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBR>(arg0, 6, b"SBR", b"SUIBEAR", b"THIS COMUNITY TOKEN DEV NO HOLD ANY AMOUNT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730992617175.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

