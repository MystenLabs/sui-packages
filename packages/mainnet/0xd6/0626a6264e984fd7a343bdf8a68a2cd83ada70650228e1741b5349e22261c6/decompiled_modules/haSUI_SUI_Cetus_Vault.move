module 0xd60626a6264e984fd7a343bdf8a68a2cd83ada70650228e1741b5349e22261c6::haSUI_SUI_Cetus_Vault {
    struct HASUI_SUI_CETUS_VAULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASUI_SUI_CETUS_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASUI_SUI_CETUS_VAULT>(arg0, 9, b"syhaSUI-SUI-vaultLP-Cetus", b"SY haSUI-SUI vaultLP Cetus", b"SY haSUI-SUI Cetus Vault LP Token (haSUI-SUI vaultLP Cetus)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HASUI_SUI_CETUS_VAULT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASUI_SUI_CETUS_VAULT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

