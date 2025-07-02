module 0xc8712c9c55b25f5a410331f86fc8103ace955c0b41582b90dfddc9f2142b738b::steamm_lp_bgeo_bfud {
    struct STEAMM_LP_BGEO_BFUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BGEO_BFUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BGEO_BFUD>(arg0, 9, b"STEAMM LP bGEO-bFUD", b"STEAMM LP Token bGEO-bFUD", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BGEO_BFUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BGEO_BFUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

