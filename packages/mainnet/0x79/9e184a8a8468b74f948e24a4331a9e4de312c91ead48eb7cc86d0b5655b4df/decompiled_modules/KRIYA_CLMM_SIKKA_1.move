module 0x799e184a8a8468b74f948e24a4331a9e4de312c91ead48eb7cc86d0b5655b4df::KRIYA_CLMM_SIKKA_1 {
    struct KRIYA_CLMM_SIKKA_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRIYA_CLMM_SIKKA_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIYA_CLMM_SIKKA_1>(arg0, 6, b"KRIYA_CLMM_SIKKA_1", b"KV_SUI_USDC", b"staging kriya clmm vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIYA_CLMM_SIKKA_1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRIYA_CLMM_SIKKA_1>>(v1);
    }

    // decompiled from Move bytecode v6
}

