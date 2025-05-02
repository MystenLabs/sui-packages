module 0x9ac2387d7d73ce78277d6272e5bb466c276f7d6014dd127ec606d31ca219beb4::steamm_lp_bsui_bisui {
    struct STEAMM_LP_BSUI_BISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUI_BISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUI_BISUI>(arg0, 9, b"STEAMM LP bSUI-biSUI", b"STEAMM LP Token bSUI-biSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUI_BISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUI_BISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

