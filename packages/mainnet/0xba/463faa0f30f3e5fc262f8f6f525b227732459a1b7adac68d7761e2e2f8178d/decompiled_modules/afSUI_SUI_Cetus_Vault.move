module 0xba463faa0f30f3e5fc262f8f6f525b227732459a1b7adac68d7761e2e2f8178d::afSUI_SUI_Cetus_Vault {
    struct AFSUI_SUI_CETUS_VAULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFSUI_SUI_CETUS_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFSUI_SUI_CETUS_VAULT>(arg0, 9, b"syAFSUI-SUI-vaultLP-Cetus", b"SY AFSUI-SUI vaultLP Cetus", b"SY AFSUI-SUI Cetus Vault LP Token (AFSUI-SUI vaultLP Cetus)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFSUI_SUI_CETUS_VAULT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFSUI_SUI_CETUS_VAULT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

