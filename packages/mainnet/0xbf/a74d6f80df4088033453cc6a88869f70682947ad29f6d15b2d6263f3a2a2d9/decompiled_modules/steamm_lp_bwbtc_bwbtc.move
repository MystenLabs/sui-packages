module 0xbfa74d6f80df4088033453cc6a88869f70682947ad29f6d15b2d6263f3a2a2d9::steamm_lp_bwbtc_bwbtc {
    struct STEAMM_LP_BWBTC_BWBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BWBTC_BWBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BWBTC_BWBTC>(arg0, 9, b"STEAMM LP bWBTC-bwBTC", b"STEAMM LP Token bWBTC-bwBTC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BWBTC_BWBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BWBTC_BWBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

