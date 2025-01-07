module 0x7335d85e4d9955c96ed4a043d0d39231dbf28acf972a702e8147c9b17b618103::kriya_navi_vt_vsui_sui {
    struct KRIYA_NAVI_VT_VSUI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRIYA_NAVI_VT_VSUI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIYA_NAVI_VT_VSUI_SUI>(arg0, 9, b"Kriya Navi Vault Token", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRIYA_NAVI_VT_VSUI_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIYA_NAVI_VT_VSUI_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

