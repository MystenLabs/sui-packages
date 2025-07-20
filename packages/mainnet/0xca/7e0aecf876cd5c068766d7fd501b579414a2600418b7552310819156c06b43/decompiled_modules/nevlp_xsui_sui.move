module 0xca7e0aecf876cd5c068766d7fd501b579414a2600418b7552310819156c06b43::nevlp_xsui_sui {
    struct NEVLP_XSUI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEVLP_XSUI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEVLP_XSUI_SUI>(arg0, 9, b"sy-nevLP-XSUI-SUI", b"SY nevLP-XSUI-SUI", b"SY nevLP-XSUI-SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEVLP_XSUI_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEVLP_XSUI_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

