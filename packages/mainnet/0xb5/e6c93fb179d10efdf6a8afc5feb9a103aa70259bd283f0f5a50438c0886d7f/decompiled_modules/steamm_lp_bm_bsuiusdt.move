module 0xb5e6c93fb179d10efdf6a8afc5feb9a103aa70259bd283f0f5a50438c0886d7f::steamm_lp_bm_bsuiusdt {
    struct STEAMM_LP_BM_BSUIUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BM_BSUIUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BM_BSUIUSDT>(arg0, 9, b"STEAMM LP bM-bsuiUSDT", b"STEAMM LP Token bM-bsuiUSDT", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BM_BSUIUSDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BM_BSUIUSDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

