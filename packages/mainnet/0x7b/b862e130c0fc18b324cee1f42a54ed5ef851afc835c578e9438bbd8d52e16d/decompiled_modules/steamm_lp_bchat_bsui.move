module 0x7bb862e130c0fc18b324cee1f42a54ed5ef851afc835c578e9438bbd8d52e16d::steamm_lp_bchat_bsui {
    struct STEAMM_LP_BCHAT_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BCHAT_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BCHAT_BSUI>(arg0, 9, b"STEAMM LP bCHAT-bSUI", b"STEAMM LP Token bCHAT-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BCHAT_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BCHAT_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

