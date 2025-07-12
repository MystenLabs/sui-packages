module 0x3311e02dd1a0eb241abce2d0fdabef02de33963902b0e3665b5695bdb07cf792::steamm_lp_bjod_bkdx {
    struct STEAMM_LP_BJOD_BKDX has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BJOD_BKDX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BJOD_BKDX>(arg0, 9, b"STEAMM LP bJOD-bKDX", b"STEAMM LP Token bJOD-bKDX", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BJOD_BKDX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BJOD_BKDX>>(v1);
    }

    // decompiled from Move bytecode v6
}

