module 0xf0d82354706dbf0f2ab77dd0c2dd63d0f74901db26c7dc8d8d651fff0599db34::steamm_lp_bcody_bsui {
    struct STEAMM_LP_BCODY_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BCODY_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BCODY_BSUI>(arg0, 9, b"STEAMM LP bCODY-bSUI", b"STEAMM LP Token bCODY-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BCODY_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BCODY_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

