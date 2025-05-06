module 0xea9ec2d46cef61e3cd000a4514190761b1c9715913017ff836d331faf8eb0e7e::steamm_lp_bvsui_bsui {
    struct STEAMM_LP_BVSUI_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BVSUI_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BVSUI_BSUI>(arg0, 9, b"STEAMM LP bvSUI-bSUI", b"STEAMM LP Token bvSUI-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BVSUI_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BVSUI_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

