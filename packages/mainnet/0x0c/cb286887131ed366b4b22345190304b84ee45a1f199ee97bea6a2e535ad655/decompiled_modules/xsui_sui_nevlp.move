module 0xccb286887131ed366b4b22345190304b84ee45a1f199ee97bea6a2e535ad655::xsui_sui_nevlp {
    struct XSUI_SUI_NEVLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSUI_SUI_NEVLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XSUI_SUI_NEVLP>(arg0, 9, b"nevLP-xSUI-SUI", b"nevLP-xSUI-SUI", b"nevLP-xSUI-SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://oss.nemoprotocol.com/vaultMmtXsuiSui.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XSUI_SUI_NEVLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XSUI_SUI_NEVLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

