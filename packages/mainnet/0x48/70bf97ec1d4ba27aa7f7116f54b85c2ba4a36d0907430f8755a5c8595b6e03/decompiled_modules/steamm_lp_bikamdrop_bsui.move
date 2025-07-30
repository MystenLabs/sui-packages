module 0x4870bf97ec1d4ba27aa7f7116f54b85c2ba4a36d0907430f8755a5c8595b6e03::steamm_lp_bikamdrop_bsui {
    struct STEAMM_LP_BIKAMDROP_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BIKAMDROP_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BIKAMDROP_BSUI>(arg0, 9, b"STEAMM LP bIKAMDROP-bSUI", b"STEAMM LP Token bIKAMDROP-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BIKAMDROP_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BIKAMDROP_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

