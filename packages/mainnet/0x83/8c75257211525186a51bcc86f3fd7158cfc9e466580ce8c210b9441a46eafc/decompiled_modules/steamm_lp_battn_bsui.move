module 0x838c75257211525186a51bcc86f3fd7158cfc9e466580ce8c210b9441a46eafc::steamm_lp_battn_bsui {
    struct STEAMM_LP_BATTN_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BATTN_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BATTN_BSUI>(arg0, 9, b"STEAMM LP bATTN-bSUI", b"STEAMM LP Token bATTN-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BATTN_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BATTN_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

