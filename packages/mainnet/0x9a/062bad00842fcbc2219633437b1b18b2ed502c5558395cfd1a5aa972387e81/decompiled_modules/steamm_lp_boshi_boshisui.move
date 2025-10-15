module 0x9a062bad00842fcbc2219633437b1b18b2ed502c5558395cfd1a5aa972387e81::steamm_lp_boshi_boshisui {
    struct STEAMM_LP_BOSHI_BOSHISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BOSHI_BOSHISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BOSHI_BOSHISUI>(arg0, 9, b"STEAMM LP bOSHI-boshiSUI", b"STEAMM LP Token bOSHI-boshiSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BOSHI_BOSHISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BOSHI_BOSHISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

