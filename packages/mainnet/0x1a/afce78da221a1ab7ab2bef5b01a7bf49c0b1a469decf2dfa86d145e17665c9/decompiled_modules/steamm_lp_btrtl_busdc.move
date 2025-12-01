module 0x1aafce78da221a1ab7ab2bef5b01a7bf49c0b1a469decf2dfa86d145e17665c9::steamm_lp_btrtl_busdc {
    struct STEAMM_LP_BTRTL_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BTRTL_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BTRTL_BUSDC>(arg0, 9, b"STEAMM LP bTRTL-bUSDC", b"STEAMM LP Token bTRTL-bUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BTRTL_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BTRTL_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

