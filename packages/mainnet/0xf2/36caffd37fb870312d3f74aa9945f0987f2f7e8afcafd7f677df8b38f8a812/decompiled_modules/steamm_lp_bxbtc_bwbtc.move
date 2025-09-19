module 0xf236caffd37fb870312d3f74aa9945f0987f2f7e8afcafd7f677df8b38f8a812::steamm_lp_bxbtc_bwbtc {
    struct STEAMM_LP_BXBTC_BWBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BXBTC_BWBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BXBTC_BWBTC>(arg0, 9, b"STEAMM LP bxBTC-bwBTC", b"STEAMM LP Token bxBTC-bwBTC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BXBTC_BWBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BXBTC_BWBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

