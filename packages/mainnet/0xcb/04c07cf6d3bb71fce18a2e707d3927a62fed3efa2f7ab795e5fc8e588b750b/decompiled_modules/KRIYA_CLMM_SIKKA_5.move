module 0xcb04c07cf6d3bb71fce18a2e707d3927a62fed3efa2f7ab795e5fc8e588b750b::KRIYA_CLMM_SIKKA_5 {
    struct KRIYA_CLMM_SIKKA_5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRIYA_CLMM_SIKKA_5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIYA_CLMM_SIKKA_5>(arg0, 6, b"KRIYA_CLMM_SIKKA_5", b"KV_SUI_USDC", b"staging kriya clmm vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIYA_CLMM_SIKKA_5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRIYA_CLMM_SIKKA_5>>(v1);
    }

    // decompiled from Move bytecode v6
}

