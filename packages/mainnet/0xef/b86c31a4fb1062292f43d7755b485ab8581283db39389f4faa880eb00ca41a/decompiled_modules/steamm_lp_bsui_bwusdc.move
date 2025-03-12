module 0xefb86c31a4fb1062292f43d7755b485ab8581283db39389f4faa880eb00ca41a::steamm_lp_bsui_bwusdc {
    struct STEAMM_LP_BSUI_BWUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUI_BWUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUI_BWUSDC>(arg0, 9, b"STEAMM LP bSUI-bwUSDC", b"STEAMM LP Token bSUI-bwUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUI_BWUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUI_BWUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

