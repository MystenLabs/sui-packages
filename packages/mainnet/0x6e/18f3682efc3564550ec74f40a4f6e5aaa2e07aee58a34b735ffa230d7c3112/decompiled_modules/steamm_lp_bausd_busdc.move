module 0x6e18f3682efc3564550ec74f40a4f6e5aaa2e07aee58a34b735ffa230d7c3112::steamm_lp_bausd_busdc {
    struct STEAMM_LP_BAUSD_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BAUSD_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BAUSD_BUSDC>(arg0, 9, b"STEAMM LP bAUSD-bUSDC", b"STEAMM LP Token bAUSD-bUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BAUSD_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BAUSD_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

