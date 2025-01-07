module 0x525451f5e8893634ff84a7008cb90b4a93031ddf4ba3704931e79f326d82863::KRIYA_CLMM_SIKKA_4 {
    struct KRIYA_CLMM_SIKKA_4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRIYA_CLMM_SIKKA_4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIYA_CLMM_SIKKA_4>(arg0, 6, b"KRIYA_CLMM_SIKKA_4", b"KV_SUI_USDC", b"staging kriya clmm vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIYA_CLMM_SIKKA_4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRIYA_CLMM_SIKKA_4>>(v1);
    }

    // decompiled from Move bytecode v6
}

