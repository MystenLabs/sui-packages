module 0xe3e4a923cff073c1f4726a8c6cddc833b5954f87e38235fe0b26e6508f4fb5d7::steamm_lp_bsend_busdt {
    struct STEAMM_LP_BSEND_BUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSEND_BUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSEND_BUSDT>(arg0, 9, b"STEAMM LP bSEND-bUSDT", b"STEAMM LP Token bSEND-bUSDT", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSEND_BUSDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSEND_BUSDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

