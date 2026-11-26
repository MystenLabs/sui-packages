module 0xcb9bc70d32c284846da3d018048b0039dc508066dc781c14b0395bd7a66e192c::jhbtc {
    struct JHBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: JHBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JHBTC>(arg0, 8, b"jhBTC", b"JewelSwap hBTC Carry", b"Share of the JewelSwap hBTC carry vault on Sui (hBTC collateral on NAVI, USDC carry)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JHBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JHBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

