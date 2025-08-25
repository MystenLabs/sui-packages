module 0xa91d581f4350c898ed906b96200dd2c4b0053dac690b88e0ecbda6fa35704246::steamm_lp_bsui_bvsui {
    struct STEAMM_LP_BSUI_BVSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUI_BVSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUI_BVSUI>(arg0, 9, b"STEAMM LP bSUI-bvSUI", b"STEAMM LP Token bSUI-bvSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUI_BVSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUI_BVSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

