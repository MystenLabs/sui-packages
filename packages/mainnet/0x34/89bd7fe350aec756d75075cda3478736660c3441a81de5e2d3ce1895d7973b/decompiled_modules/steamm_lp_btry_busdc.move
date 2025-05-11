module 0x3489bd7fe350aec756d75075cda3478736660c3441a81de5e2d3ce1895d7973b::steamm_lp_btry_busdc {
    struct STEAMM_LP_BTRY_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BTRY_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BTRY_BUSDC>(arg0, 9, b"STEAMM LP bTRY-bUSDC", b"STEAMM LP Token bTRY-bUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BTRY_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BTRY_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

