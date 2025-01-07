module 0x97327180a233854449620e90b41a9450f131a3aa1d1dc08f3398b6c1c9415ecc::kriya_ssui_sui_vt {
    struct KRIYA_SSUI_SUI_VT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRIYA_SSUI_SUI_VT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIYA_SSUI_SUI_VT>(arg0, 6, b"Kriya Suilend Vault Token", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRIYA_SSUI_SUI_VT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIYA_SSUI_SUI_VT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

