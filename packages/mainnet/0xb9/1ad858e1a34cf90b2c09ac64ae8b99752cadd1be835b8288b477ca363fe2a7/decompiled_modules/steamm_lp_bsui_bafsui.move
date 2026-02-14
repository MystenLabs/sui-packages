module 0xb91ad858e1a34cf90b2c09ac64ae8b99752cadd1be835b8288b477ca363fe2a7::steamm_lp_bsui_bafsui {
    struct STEAMM_LP_BSUI_BAFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUI_BAFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUI_BAFSUI>(arg0, 9, b"STEAMM LP bSUI-bAFSUI", b"STEAMM LP Token bSUI-bAFSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUI_BAFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUI_BAFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

