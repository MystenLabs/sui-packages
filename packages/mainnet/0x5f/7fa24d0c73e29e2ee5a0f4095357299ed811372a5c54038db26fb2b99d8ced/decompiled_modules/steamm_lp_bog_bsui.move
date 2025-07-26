module 0x5f7fa24d0c73e29e2ee5a0f4095357299ed811372a5c54038db26fb2b99d8ced::steamm_lp_bog_bsui {
    struct STEAMM_LP_BOG_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BOG_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BOG_BSUI>(arg0, 9, b"STEAMM LP bOG-bSUI", b"STEAMM LP Token bOG-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BOG_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BOG_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

