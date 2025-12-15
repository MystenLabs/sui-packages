module 0x3c3b0b91952215fc1379c704d102b2a7be50c771a93df231352bef8ee7b71d43::steamm_lp_bmagma_bsui {
    struct STEAMM_LP_BMAGMA_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BMAGMA_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BMAGMA_BSUI>(arg0, 9, b"STEAMM LP bMAGMA-bSUI", b"STEAMM LP Token bMAGMA-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BMAGMA_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BMAGMA_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

