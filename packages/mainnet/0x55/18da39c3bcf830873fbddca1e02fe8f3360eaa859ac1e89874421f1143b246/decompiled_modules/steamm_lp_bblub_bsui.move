module 0x5518da39c3bcf830873fbddca1e02fe8f3360eaa859ac1e89874421f1143b246::steamm_lp_bblub_bsui {
    struct STEAMM_LP_BBLUB_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BBLUB_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BBLUB_BSUI>(arg0, 9, b"STEAMM LP bBLUB-bSUI", b"STEAMM LP Token bBLUB-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BBLUB_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BBLUB_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

