module 0x96eb2012a75798ce4410392baeab9dd888bc704799b7daa468c36856c83174f3::ALPHAFI_STSUI_SUI_LP {
    struct ALPHAFI_STSUI_SUI_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHAFI_STSUI_SUI_LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHAFI_STSUI_SUI_LP>(arg0, 9, b"AlphaFi stSUI-SUI LP", b"AlphaFi stSUI-SUI LP", x"546f6b656e697a6564207374616b6520696e20416c7068614669e28099732073745355492d535549207661756c742c20656e61626c696e67207365616d6c657373206c69717569646974792070726f766973696f6e20746f20426c756566696e207768696c6520656e737572696e67206175746f2d62616c616e63696e6720616e6420636f6d706f756e64696e6720666f72206f7074696d616c207969656c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.alphafi.xyz/stSUI-SUI-FT-Bluefin.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALPHAFI_STSUI_SUI_LP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHAFI_STSUI_SUI_LP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

