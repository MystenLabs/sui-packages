module 0x28a97f917e8e0d113a6f9a6d94ac7848035e18ab247df30f2e91c75d1fc7777a::steamm_lp_bssui_bksui {
    struct STEAMM_LP_BSSUI_BKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSSUI_BKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSSUI_BKSUI>(arg0, 9, b"STEAMM LP bsSUI-bkSUI", b"STEAMM LP Token bsSUI-bkSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSSUI_BKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSSUI_BKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

