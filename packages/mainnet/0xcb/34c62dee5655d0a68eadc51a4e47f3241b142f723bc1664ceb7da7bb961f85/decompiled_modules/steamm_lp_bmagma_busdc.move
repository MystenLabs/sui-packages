module 0xcb34c62dee5655d0a68eadc51a4e47f3241b142f723bc1664ceb7da7bb961f85::steamm_lp_bmagma_busdc {
    struct STEAMM_LP_BMAGMA_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BMAGMA_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BMAGMA_BUSDC>(arg0, 9, b"STEAMM LP bMAGMA-bUSDC", b"STEAMM LP Token bMAGMA-bUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BMAGMA_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BMAGMA_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

