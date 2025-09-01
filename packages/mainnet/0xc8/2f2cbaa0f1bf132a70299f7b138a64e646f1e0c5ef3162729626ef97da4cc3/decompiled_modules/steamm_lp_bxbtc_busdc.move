module 0xc82f2cbaa0f1bf132a70299f7b138a64e646f1e0c5ef3162729626ef97da4cc3::steamm_lp_bxbtc_busdc {
    struct STEAMM_LP_BXBTC_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BXBTC_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BXBTC_BUSDC>(arg0, 9, b"STEAMM LP bxBTC-bUSDC", b"STEAMM LP Token bxBTC-bUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BXBTC_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BXBTC_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

