module 0x3e13f35c52ce50b321cf9195fc21d88ac989e5694f767371656de43644c5584c::steamm_lp_bfold_bsui {
    struct STEAMM_LP_BFOLD_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BFOLD_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BFOLD_BSUI>(arg0, 9, b"STEAMM LP bFOLD-bSUI", b"STEAMM LP Token bFOLD-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BFOLD_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BFOLD_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

