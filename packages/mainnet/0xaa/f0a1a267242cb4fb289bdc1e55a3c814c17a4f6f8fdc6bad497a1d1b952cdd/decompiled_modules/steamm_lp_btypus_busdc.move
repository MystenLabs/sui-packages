module 0xaaf0a1a267242cb4fb289bdc1e55a3c814c17a4f6f8fdc6bad497a1d1b952cdd::steamm_lp_btypus_busdc {
    struct STEAMM_LP_BTYPUS_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BTYPUS_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BTYPUS_BUSDC>(arg0, 9, b"STEAMM LP bTYPUS-bUSDC", b"STEAMM LP Token bTYPUS-bUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BTYPUS_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BTYPUS_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

