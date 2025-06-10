module 0x6dc58f12302cb4247a7a4ed9df2c2f362caa2697c1f83368939ad1e0c6d29393::steamm_lp_bnosui_bsui {
    struct STEAMM_LP_BNOSUI_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BNOSUI_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BNOSUI_BSUI>(arg0, 9, b"STEAMM LP bnoSUI-bSUI", b"STEAMM LP Token bnoSUI-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BNOSUI_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BNOSUI_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

