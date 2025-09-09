module 0xf00dc74612276d716bf72c80ce24c9d327340b7205c2d2a94b185ad434bb9c54::steamm_lp_busdc_blars {
    struct STEAMM_LP_BUSDC_BLARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BUSDC_BLARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BUSDC_BLARS>(arg0, 9, b"STEAMM LP bUSDC-bLARS", b"STEAMM LP Token bUSDC-bLARS", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BUSDC_BLARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BUSDC_BLARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

