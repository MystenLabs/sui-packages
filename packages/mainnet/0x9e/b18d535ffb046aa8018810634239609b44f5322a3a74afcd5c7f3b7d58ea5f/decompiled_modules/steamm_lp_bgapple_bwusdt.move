module 0x9eb18d535ffb046aa8018810634239609b44f5322a3a74afcd5c7f3b7d58ea5f::steamm_lp_bgapple_bwusdt {
    struct STEAMM_LP_BGAPPLE_BWUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BGAPPLE_BWUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BGAPPLE_BWUSDT>(arg0, 9, b"STEAMM LP bGAPPLE-bwUSDT", b"STEAMM LP Token bGAPPLE-bwUSDT", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BGAPPLE_BWUSDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BGAPPLE_BWUSDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

