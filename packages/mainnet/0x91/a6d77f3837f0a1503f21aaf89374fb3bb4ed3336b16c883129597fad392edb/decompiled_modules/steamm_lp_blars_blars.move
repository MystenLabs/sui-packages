module 0x91a6d77f3837f0a1503f21aaf89374fb3bb4ed3336b16c883129597fad392edb::steamm_lp_blars_blars {
    struct STEAMM_LP_BLARS_BLARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BLARS_BLARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BLARS_BLARS>(arg0, 9, b"STEAMM LP bLARS-bLARS", b"STEAMM LP Token bLARS-bLARS", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BLARS_BLARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BLARS_BLARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

