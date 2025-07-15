module 0x20546043c28ec0680336d1ea1331556f093957e5f0083a164ecd6d9e9882ae0b::steamm_lp_bndd_bsui {
    struct STEAMM_LP_BNDD_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BNDD_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BNDD_BSUI>(arg0, 9, b"STEAMM LP bNDD-bSUI", b"STEAMM LP Token bNDD-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BNDD_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BNDD_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

