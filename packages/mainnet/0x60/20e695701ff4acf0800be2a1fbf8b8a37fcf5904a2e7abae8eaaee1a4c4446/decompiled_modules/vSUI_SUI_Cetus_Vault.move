module 0x6020e695701ff4acf0800be2a1fbf8b8a37fcf5904a2e7abae8eaaee1a4c4446::vSUI_SUI_Cetus_Vault {
    struct VSUI_SUI_CETUS_VAULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VSUI_SUI_CETUS_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VSUI_SUI_CETUS_VAULT>(arg0, 9, b"syvSUI-SUI-vaultLP-Cetus", b"SY vSUI-SUI vaultLP Cetus", b"SY vSUI-SUI Cetus Vault LP Token (vSUI-SUI vaultLP Cetus)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VSUI_SUI_CETUS_VAULT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VSUI_SUI_CETUS_VAULT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

