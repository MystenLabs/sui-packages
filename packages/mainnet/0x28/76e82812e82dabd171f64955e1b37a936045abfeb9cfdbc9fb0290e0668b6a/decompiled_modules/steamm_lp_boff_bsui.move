module 0x2876e82812e82dabd171f64955e1b37a936045abfeb9cfdbc9fb0290e0668b6a::steamm_lp_boff_bsui {
    struct STEAMM_LP_BOFF_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BOFF_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BOFF_BSUI>(arg0, 9, b"STEAMM LP bOFF-bSUI", b"STEAMM LP Token bOFF-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BOFF_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BOFF_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

