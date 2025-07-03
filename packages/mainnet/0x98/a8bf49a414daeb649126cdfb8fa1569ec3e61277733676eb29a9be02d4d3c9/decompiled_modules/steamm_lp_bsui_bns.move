module 0x98a8bf49a414daeb649126cdfb8fa1569ec3e61277733676eb29a9be02d4d3c9::steamm_lp_bsui_bns {
    struct STEAMM_LP_BSUI_BNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUI_BNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUI_BNS>(arg0, 9, b"STEAMM LP bSUI-bNS", b"STEAMM LP Token bSUI-bNS", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUI_BNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUI_BNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

