module 0xddac4642de47089c5eed78202b1e60b45d5c11986e051284805f742a8c5d58cf::steamm_lp_bsail_bpresail {
    struct STEAMM_LP_BSAIL_BPRESAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSAIL_BPRESAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSAIL_BPRESAIL>(arg0, 9, b"STEAMM LP bSAIL-bpreSAIL", b"STEAMM LP Token bSAIL-bpreSAIL", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSAIL_BPRESAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSAIL_BPRESAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

