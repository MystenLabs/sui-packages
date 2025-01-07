module 0xb70b787825fcbb69ff468025f48f2ee6b7cbb9f3512e7ad89d2e406548717a8::KRIYA_CLMM_SIKKA_2 {
    struct KRIYA_CLMM_SIKKA_2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRIYA_CLMM_SIKKA_2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIYA_CLMM_SIKKA_2>(arg0, 6, b"KRIYA_CLMM_SIKKA_2", b"KV_SUI_USDC", b"staging kriya clmm vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIYA_CLMM_SIKKA_2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRIYA_CLMM_SIKKA_2>>(v1);
    }

    // decompiled from Move bytecode v6
}

