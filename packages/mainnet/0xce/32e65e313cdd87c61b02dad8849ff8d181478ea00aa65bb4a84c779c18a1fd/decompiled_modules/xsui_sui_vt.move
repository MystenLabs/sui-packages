module 0xce32e65e313cdd87c61b02dad8849ff8d181478ea00aa65bb4a84c779c18a1fd::xsui_sui_vt {
    struct XSUI_SUI_VT has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSUI_SUI_VT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XSUI_SUI_VT>(arg0, 9, b"xsui-sui", b"xsui-sui", b"mmt xsui-sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://oss.nemoprotocol.com/vaultMmtXsuiSui.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XSUI_SUI_VT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XSUI_SUI_VT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

