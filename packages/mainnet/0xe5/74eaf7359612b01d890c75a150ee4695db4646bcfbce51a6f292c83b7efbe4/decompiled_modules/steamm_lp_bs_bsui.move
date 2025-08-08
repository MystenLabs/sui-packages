module 0xe574eaf7359612b01d890c75a150ee4695db4646bcfbce51a6f292c83b7efbe4::steamm_lp_bs_bsui {
    struct STEAMM_LP_BS_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BS_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BS_BSUI>(arg0, 9, b"STEAMM LP bS-bSUI", b"STEAMM LP Token bS-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BS_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BS_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

