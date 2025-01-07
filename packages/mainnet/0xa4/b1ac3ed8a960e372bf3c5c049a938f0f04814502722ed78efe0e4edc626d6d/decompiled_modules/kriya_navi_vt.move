module 0xa4b1ac3ed8a960e372bf3c5c049a938f0f04814502722ed78efe0e4edc626d6d::kriya_navi_vt {
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

