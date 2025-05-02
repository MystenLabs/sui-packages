module 0x645bde5f7d39f98b0cd0e217f9a5e48ea730b810f82a9fcad6333b6feb653f63::steamm_lp_brebel_bsui {
    struct STEAMM_LP_BREBEL_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BREBEL_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BREBEL_BSUI>(arg0, 9, b"STEAMM LP bREBEL-bSUI", b"STEAMM LP Token bREBEL-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BREBEL_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BREBEL_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

