module 0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::usdx {
    struct USDX has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<USDX>(arg0, 6, 0x1::string::utf8(b"USDX"), 0x1::string::utf8(b"USDX"), 0x1::string::utf8(b"Stablecoin minted via cross-chain deposit"), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<USDX>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

