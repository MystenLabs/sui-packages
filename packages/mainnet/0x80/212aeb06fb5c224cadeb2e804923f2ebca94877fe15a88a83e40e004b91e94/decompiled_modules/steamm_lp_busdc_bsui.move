module 0x80212aeb06fb5c224cadeb2e804923f2ebca94877fe15a88a83e40e004b91e94::steamm_lp_busdc_bsui {
    struct STEAMM_LP_BUSDC_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BUSDC_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BUSDC_BSUI>(arg0, 9, b"STEAMM LP bUSDC-bSUI", b"STEAMM LP Token bUSDC-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BUSDC_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BUSDC_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

