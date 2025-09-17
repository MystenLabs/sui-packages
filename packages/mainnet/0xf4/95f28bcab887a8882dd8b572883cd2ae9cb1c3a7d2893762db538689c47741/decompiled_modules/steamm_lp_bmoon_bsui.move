module 0xf495f28bcab887a8882dd8b572883cd2ae9cb1c3a7d2893762db538689c47741::steamm_lp_bmoon_bsui {
    struct STEAMM_LP_BMOON_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BMOON_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BMOON_BSUI>(arg0, 9, b"STEAMM LP bMOON-bSUI", b"STEAMM LP Token bMOON-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BMOON_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BMOON_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

