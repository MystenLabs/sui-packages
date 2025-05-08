module 0x954ad4112300ee5c1176e79ddf5ea742ac57451c1861e98449fd2bc99511a8f9::steamm_lp_bx123_bbuck {
    struct STEAMM_LP_BX123_BBUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BX123_BBUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BX123_BBUCK>(arg0, 9, b"STEAMM LP bX123-bBUCK", b"STEAMM LP Token bX123-bBUCK", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BX123_BBUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BX123_BBUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

