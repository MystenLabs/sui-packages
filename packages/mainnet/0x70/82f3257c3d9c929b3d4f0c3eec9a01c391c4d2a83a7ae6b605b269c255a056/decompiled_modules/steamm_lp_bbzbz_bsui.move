module 0x7082f3257c3d9c929b3d4f0c3eec9a01c391c4d2a83a7ae6b605b269c255a056::steamm_lp_bbzbz_bsui {
    struct STEAMM_LP_BBZBZ_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BBZBZ_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BBZBZ_BSUI>(arg0, 9, b"STEAMM LP bBZBZ-bSUI", b"STEAMM LP Token bBZBZ-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BBZBZ_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BBZBZ_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

