module 0x444a18913d0ab1b282bf5b7d8f9c409cf048fde58d7cb395d380d69fa5437fc3::KRIYA_CLMM_SIKKA_3 {
    struct KRIYA_CLMM_SIKKA_3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRIYA_CLMM_SIKKA_3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIYA_CLMM_SIKKA_3>(arg0, 6, b"KRIYA_CLMM_SIKKA_3", b"KV_SUI_USDC", b"staging kriya clmm vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIYA_CLMM_SIKKA_3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRIYA_CLMM_SIKKA_3>>(v1);
    }

    // decompiled from Move bytecode v6
}

