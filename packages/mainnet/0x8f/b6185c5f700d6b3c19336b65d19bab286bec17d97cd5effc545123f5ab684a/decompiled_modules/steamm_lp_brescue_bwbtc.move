module 0x8fb6185c5f700d6b3c19336b65d19bab286bec17d97cd5effc545123f5ab684a::steamm_lp_brescue_bwbtc {
    struct STEAMM_LP_BRESCUE_BWBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BRESCUE_BWBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BRESCUE_BWBTC>(arg0, 9, b"STEAMM LP bRESCUE-bwBTC", b"STEAMM LP Token bRESCUE-bwBTC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BRESCUE_BWBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BRESCUE_BWBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

