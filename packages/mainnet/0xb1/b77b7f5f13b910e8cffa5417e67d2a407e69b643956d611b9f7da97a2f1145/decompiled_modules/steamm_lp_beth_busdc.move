module 0xb1b77b7f5f13b910e8cffa5417e67d2a407e69b643956d611b9f7da97a2f1145::steamm_lp_beth_busdc {
    struct STEAMM_LP_BETH_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BETH_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BETH_BUSDC>(arg0, 9, b"STEAMM LP bETH-bUSDC", b"STEAMM LP Token bETH-bUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BETH_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BETH_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

