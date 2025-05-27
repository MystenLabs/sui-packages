module 0x3984ef2e44352412b83d9be79d4fc16ab938d8f3d4f4796dad41c5b0e36a6784::steamm_lp_bpogu_busdc {
    struct STEAMM_LP_BPOGU_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BPOGU_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BPOGU_BUSDC>(arg0, 9, b"STEAMM LP bPOGU-bUSDC", b"STEAMM LP Token bPOGU-bUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BPOGU_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BPOGU_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

