module 0x44d92784e505ef857eada17b6fce61a6b01267771e5d4f714db6dc1db5f9b587::steamm_lp_bsend_bnavx {
    struct STEAMM_LP_BSEND_BNAVX has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSEND_BNAVX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSEND_BNAVX>(arg0, 9, b"STEAMM LP bSEND-bNAVX", b"STEAMM LP Token bSEND-bNAVX", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSEND_BNAVX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSEND_BNAVX>>(v1);
    }

    // decompiled from Move bytecode v6
}

