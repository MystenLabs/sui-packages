module 0xf8e11dd28bddc6d71e8a1a7645608ddb20baaf949faa1d15665357123c43e75a::steamm_lp_bwal_busdc {
    struct STEAMM_LP_BWAL_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BWAL_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BWAL_BUSDC>(arg0, 9, b"STEAMM LP bWAL-bUSDC", b"STEAMM LP Token bWAL-bUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BWAL_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BWAL_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

