module 0x2ec9cbb5d1474df6f546e39cbc4f0ac190ae61668d2397855f72029862ecc542::steamm_lp_bpigu_bfud {
    struct STEAMM_LP_BPIGU_BFUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BPIGU_BFUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BPIGU_BFUD>(arg0, 9, b"STEAMM LP bPIGU-bFUD", b"STEAMM LP Token bPIGU-bFUD", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BPIGU_BFUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BPIGU_BFUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

