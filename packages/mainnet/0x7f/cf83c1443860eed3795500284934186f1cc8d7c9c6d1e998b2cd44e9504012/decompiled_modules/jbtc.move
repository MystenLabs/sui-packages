module 0x7fcf83c1443860eed3795500284934186f1cc8d7c9c6d1e998b2cd44e9504012::jbtc {
    struct JBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: JBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JBTC>(arg0, 8, b"jBTC", b"JewelSwap jBTC", b"Share of the JewelSwap zwBTC vault on Sui (NAVI zwBTC/xBTC loop)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

