module 0x9d8b8056e0e8f5b9aa74b71f85db0a1a82c738d8a871db1df59dc00a3816f4b1::steamm_lp_bpoopsui_bsend {
    struct STEAMM_LP_BPOOPSUI_BSEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BPOOPSUI_BSEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BPOOPSUI_BSEND>(arg0, 9, b"STEAMM LP bpoopSUI-bSEND", b"STEAMM LP Token bpoopSUI-bSEND", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BPOOPSUI_BSEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BPOOPSUI_BSEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

