module 0x5835e0870985eec924fd14fe096d42ce2c905072087f5fb75c412746712df379::steamm_lp_bm_bsend {
    struct STEAMM_LP_BM_BSEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BM_BSEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BM_BSEND>(arg0, 9, b"STEAMM LP bM-bSEND", b"STEAMM LP Token bM-bSEND", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BM_BSEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BM_BSEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

