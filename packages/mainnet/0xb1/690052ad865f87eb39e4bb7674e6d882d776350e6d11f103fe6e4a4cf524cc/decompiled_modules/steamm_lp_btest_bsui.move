module 0xb1690052ad865f87eb39e4bb7674e6d882d776350e6d11f103fe6e4a4cf524cc::steamm_lp_btest_bsui {
    struct STEAMM_LP_BTEST_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BTEST_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BTEST_BSUI>(arg0, 9, b"STEAMM LP bTEST-bSUI", b"STEAMM LP Token bTEST-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BTEST_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BTEST_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

