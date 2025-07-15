module 0xd50552543316c0d660715551095dd849c6215add77cd48d358bd3b028d670513::steamm_lp_bhappy_bsui {
    struct STEAMM_LP_BHAPPY_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BHAPPY_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BHAPPY_BSUI>(arg0, 9, b"STEAMM LP bHAPPY-bSUI", b"STEAMM LP Token bHAPPY-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BHAPPY_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BHAPPY_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

