module 0xf1163c8e4cf1c031298e403f37fddc1d02f13c57a8e78a51745c1a9a7114a482::steamm_lp_bxsui_bxsui {
    struct STEAMM_LP_BXSUI_BXSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BXSUI_BXSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BXSUI_BXSUI>(arg0, 9, b"STEAMM LP bxSUI-bxSUI", b"STEAMM LP Token bxSUI-bxSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BXSUI_BXSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BXSUI_BXSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

