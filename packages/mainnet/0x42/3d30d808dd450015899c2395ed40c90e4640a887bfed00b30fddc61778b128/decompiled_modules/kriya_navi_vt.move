module 0x423d30d808dd450015899c2395ed40c90e4640a887bfed00b30fddc61778b128::kriya_navi_vt {
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

