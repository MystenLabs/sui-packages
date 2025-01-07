module 0x749e780a64e5406751d0ad799a48c1f2d9c59f3f4aff77e6056da442dcbb8de5::kriya_navi_vt {
    struct KRIYA_NAVI_VT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRIYA_NAVI_VT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIYA_NAVI_VT>(arg0, 8, b"Kriya Navi Vault Token", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRIYA_NAVI_VT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIYA_NAVI_VT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

