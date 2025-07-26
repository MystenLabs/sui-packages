module 0xe790e1d45e2a8cf8e348774370e78cf5f5a0bc47c13869c69cf6dd6fc8009b37::steamm_lp_bbella_bsui {
    struct STEAMM_LP_BBELLA_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BBELLA_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BBELLA_BSUI>(arg0, 9, b"STEAMM LP bBELLA-bSUI", b"STEAMM LP Token bBELLA-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BBELLA_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BBELLA_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

