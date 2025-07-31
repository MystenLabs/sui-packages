module 0xd908810571c69e3e7251a1e0c67964129deb55eb9e3f907fa4aff0120f15a810::steamm_lp_bbuck_busdc {
    struct STEAMM_LP_BBUCK_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BBUCK_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BBUCK_BUSDC>(arg0, 9, b"STEAMM LP bBUCK-bUSDC", b"STEAMM LP Token bBUCK-bUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BBUCK_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BBUCK_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

