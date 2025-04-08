module 0xb098658bc32a4fbe93633627d87c59cd6f6e58979e9cd3542fd3c8da95c08a86::steamm_lp_bsui_busdc {
    struct STEAMM_LP_BSUI_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUI_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUI_BUSDC>(arg0, 9, b"STEAMM LP bSUI-bUSDC", b"STEAMM LP Token bSUI-bUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUI_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUI_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

