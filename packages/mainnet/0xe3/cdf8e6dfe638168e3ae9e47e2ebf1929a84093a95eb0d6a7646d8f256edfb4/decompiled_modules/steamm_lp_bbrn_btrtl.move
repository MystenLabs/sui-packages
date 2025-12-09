module 0xe3cdf8e6dfe638168e3ae9e47e2ebf1929a84093a95eb0d6a7646d8f256edfb4::steamm_lp_bbrn_btrtl {
    struct STEAMM_LP_BBRN_BTRTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BBRN_BTRTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BBRN_BTRTL>(arg0, 9, b"STEAMM LP bBRN-bTRTL", b"STEAMM LP Token bBRN-bTRTL", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BBRN_BTRTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BBRN_BTRTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

