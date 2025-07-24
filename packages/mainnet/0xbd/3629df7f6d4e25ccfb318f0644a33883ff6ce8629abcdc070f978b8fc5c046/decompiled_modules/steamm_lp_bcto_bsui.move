module 0xbd3629df7f6d4e25ccfb318f0644a33883ff6ce8629abcdc070f978b8fc5c046::steamm_lp_bcto_bsui {
    struct STEAMM_LP_BCTO_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BCTO_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BCTO_BSUI>(arg0, 9, b"STEAMM LP bCTO-bSUI", b"STEAMM LP Token bCTO-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BCTO_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BCTO_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

