module 0x6a401a61bcf19ce29c000602b284627508022c707ff23cb10862a7ea63d231ea::haSUI_SUI {
    struct HASUI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASUI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASUI_SUI>(arg0, 9, b"syhaSUI-SUI-vaultLP-Cetus", b"SY haSUI-SUI vaultLP Cetus", b"SY haSUI-SUI Cetus Vault LP Token (haSUI-SUI vaultLP Cetus)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HASUI_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASUI_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

