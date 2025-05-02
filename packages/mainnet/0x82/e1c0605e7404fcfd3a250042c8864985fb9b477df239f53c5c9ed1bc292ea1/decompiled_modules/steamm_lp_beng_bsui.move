module 0x82e1c0605e7404fcfd3a250042c8864985fb9b477df239f53c5c9ed1bc292ea1::steamm_lp_beng_bsui {
    struct STEAMM_LP_BENG_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BENG_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BENG_BSUI>(arg0, 9, b"STEAMM LP bENG-bSUI", b"STEAMM LP Token bENG-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BENG_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BENG_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

