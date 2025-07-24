module 0xc0df35a05f8dabd3252e7ce33ccd3224ff271c1177f3f1fb4bf92fca2d2dbf4d::steamm_lp_bocto_bsui {
    struct STEAMM_LP_BOCTO_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BOCTO_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BOCTO_BSUI>(arg0, 9, b"STEAMM LP bOCTO-bSUI", b"STEAMM LP Token bOCTO-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BOCTO_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BOCTO_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

