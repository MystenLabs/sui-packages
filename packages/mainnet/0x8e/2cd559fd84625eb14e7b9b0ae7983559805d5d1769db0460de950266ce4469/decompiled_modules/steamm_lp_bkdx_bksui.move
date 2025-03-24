module 0x8e2cd559fd84625eb14e7b9b0ae7983559805d5d1769db0460de950266ce4469::steamm_lp_bkdx_bksui {
    struct STEAMM_LP_BKDX_BKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BKDX_BKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BKDX_BKSUI>(arg0, 9, b"STEAMM LP bKDX-bkSUI", b"STEAMM LP Token bKDX-bkSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BKDX_BKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BKDX_BKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

