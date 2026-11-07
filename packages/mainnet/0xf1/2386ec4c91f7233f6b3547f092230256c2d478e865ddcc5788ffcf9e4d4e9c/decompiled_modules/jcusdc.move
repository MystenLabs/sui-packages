module 0xf12386ec4c91f7233f6b3547f092230256c2d478e865ddcc5788ffcf9e4d4e9c::jcusdc {
    struct JCUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: JCUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JCUSDC>(arg0, 6, b"jcUSDC", b"JewelSwap Curated USDC", b"Share of the JewelSwap Curated USDC Vault on Sui (USDC lent across NAVI and other Sui lenders)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JCUSDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JCUSDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

