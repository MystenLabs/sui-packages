module 0x186ebb9a467f7ee40f3b7274117a45e24aef9eaebc549b77e38d4e635f82b50d::steamm_lp_bboga_bsui {
    struct STEAMM_LP_BBOGA_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BBOGA_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BBOGA_BSUI>(arg0, 9, b"STEAMM LP bBOGA-bSUI", b"STEAMM LP Token bBOGA-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BBOGA_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BBOGA_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

