module 0xb535492d6003dbb879fce215510e10ad01490432c25bb363d94ad24896667042::samusdcv2 {
    struct SAMUSDCV2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMUSDCV2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SAMUSDCV2>(arg0, 6, 0x1::string::utf8(b"samUSDC"), 0x1::string::utf8(b"SAM USDC"), 0x1::string::utf8(b"SAM yield-bearing USDC"), 0x1::string::utf8(b""), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMUSDCV2>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SAMUSDCV2>>(0x2::coin_registry::finalize<SAMUSDCV2>(v0, arg1), v2);
    }

    // decompiled from Move bytecode v7
}

