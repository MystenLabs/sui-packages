module 0x9c60e95d051fb06097905c368298e5d1bd0952e3c6de69c822774b87ca91bcba::steamm_lp_steamm_bdeep_steamm_bsuiusdt {
    struct STEAMM_LP_STEAMM_BDEEP_STEAMM_BSUIUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_STEAMM_BDEEP_STEAMM_BSUIUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_STEAMM_BDEEP_STEAMM_BSUIUSDT>(arg0, 9, b"STEAMM LP STEAMM bDEEP-STEAMM bsuiUSDT", b"STEAMM LP Token STEAMM bDEEP-STEAMM bsuiUSDT", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_STEAMM_BDEEP_STEAMM_BSUIUSDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_STEAMM_BDEEP_STEAMM_BSUIUSDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

