module 0xa86f45decde6b3f99d1697a8584af707d693cd5099b8e81f470a05a803369086::KRIYA_CLMM_SIKKA {
    struct KRIYA_CLMM_SIKKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRIYA_CLMM_SIKKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIYA_CLMM_SIKKA>(arg0, 6, b"KRIYA_CLMM_SIKKA", b"KV_SUI_USDC", b"staging kriya clmm vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIYA_CLMM_SIKKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRIYA_CLMM_SIKKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

