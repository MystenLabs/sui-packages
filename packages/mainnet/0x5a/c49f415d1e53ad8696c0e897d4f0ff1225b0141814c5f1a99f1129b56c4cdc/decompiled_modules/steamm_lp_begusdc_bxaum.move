module 0x5ac49f415d1e53ad8696c0e897d4f0ff1225b0141814c5f1a99f1129b56c4cdc::steamm_lp_begusdc_bxaum {
    struct STEAMM_LP_BEGUSDC_BXAUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BEGUSDC_BXAUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BEGUSDC_BXAUM>(arg0, 9, b"STEAMM LP begUSDC-bXAUM", b"STEAMM LP Token begUSDC-bXAUM", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BEGUSDC_BXAUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BEGUSDC_BXAUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

