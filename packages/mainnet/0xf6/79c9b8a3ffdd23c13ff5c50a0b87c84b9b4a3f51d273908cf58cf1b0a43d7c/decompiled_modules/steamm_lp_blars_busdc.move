module 0xf679c9b8a3ffdd23c13ff5c50a0b87c84b9b4a3f51d273908cf58cf1b0a43d7c::steamm_lp_blars_busdc {
    struct STEAMM_LP_BLARS_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BLARS_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BLARS_BUSDC>(arg0, 9, b"STEAMM LP bLARS-bUSDC", b"STEAMM LP Token bLARS-bUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BLARS_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BLARS_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

