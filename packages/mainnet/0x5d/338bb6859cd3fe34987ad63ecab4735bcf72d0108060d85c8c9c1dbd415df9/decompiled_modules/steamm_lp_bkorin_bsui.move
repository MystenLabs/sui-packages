module 0x5d338bb6859cd3fe34987ad63ecab4735bcf72d0108060d85c8c9c1dbd415df9::steamm_lp_bkorin_bsui {
    struct STEAMM_LP_BKORIN_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BKORIN_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BKORIN_BSUI>(arg0, 9, b"STEAMM LP bKORIN-bSUI", b"STEAMM LP Token bKORIN-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BKORIN_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BKORIN_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

