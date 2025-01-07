module 0x74edaeb5f12afeb715b1f6c42b0b187791380f04973419129b4836b98bfa1dae::kriya_scallop_vt_afsui_sui {
    struct KRIYA_SCALLOP_VT_AFSUI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRIYA_SCALLOP_VT_AFSUI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIYA_SCALLOP_VT_AFSUI_SUI>(arg0, 9, b"Kriya Scallop Vault Token", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRIYA_SCALLOP_VT_AFSUI_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIYA_SCALLOP_VT_AFSUI_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

