module 0x7ca8e8db16bd0834b7bacc0044cda23ea0b13c66ac4d7eb6b6e03fff50e79082::steamm_lp_blars_btrtl {
    struct STEAMM_LP_BLARS_BTRTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BLARS_BTRTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BLARS_BTRTL>(arg0, 9, b"STEAMM LP bLARS-bTRTL", b"STEAMM LP Token bLARS-bTRTL", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BLARS_BTRTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BLARS_BTRTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

