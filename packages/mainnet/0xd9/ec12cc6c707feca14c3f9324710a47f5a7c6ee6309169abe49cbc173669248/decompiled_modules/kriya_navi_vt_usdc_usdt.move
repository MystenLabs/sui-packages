module 0xd9ec12cc6c707feca14c3f9324710a47f5a7c6ee6309169abe49cbc173669248::kriya_navi_vt_usdc_usdt {
    struct KRIYA_NAVI_VT_USDC_USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRIYA_NAVI_VT_USDC_USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIYA_NAVI_VT_USDC_USDT>(arg0, 8, b"Kriya Navi Vault Token", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRIYA_NAVI_VT_USDC_USDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIYA_NAVI_VT_USDC_USDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

