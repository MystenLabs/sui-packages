module 0xca4ceb4fe74425f6e2db0aeb4acf8c9397a3a066c10aff84f83d5b692a550868::steamm_lp_bsui_boinksui {
    struct STEAMM_LP_BSUI_BOINKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUI_BOINKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUI_BOINKSUI>(arg0, 9, b"STEAMM LP bSUI-boinkSUI", b"STEAMM LP Token bSUI-boinkSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUI_BOINKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUI_BOINKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

