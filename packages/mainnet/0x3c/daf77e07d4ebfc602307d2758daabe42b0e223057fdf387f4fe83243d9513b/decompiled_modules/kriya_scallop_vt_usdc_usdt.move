module 0x3cdaf77e07d4ebfc602307d2758daabe42b0e223057fdf387f4fe83243d9513b::kriya_scallop_vt_usdc_usdt {
    struct KRIYA_SCALLOP_VT_USDC_USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRIYA_SCALLOP_VT_USDC_USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIYA_SCALLOP_VT_USDC_USDT>(arg0, 6, b"Kriya Scallop Vault Token", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRIYA_SCALLOP_VT_USDC_USDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIYA_SCALLOP_VT_USDC_USDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

