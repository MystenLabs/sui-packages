module 0xb3d8d2b26d95b6817545678c8ffb66fe79116974a7f30ba76e9db88745aea339::steamm_lp_bads_bsui {
    struct STEAMM_LP_BADS_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BADS_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BADS_BSUI>(arg0, 9, b"STEAMM LP bADS-bSUI", b"STEAMM LP Token bADS-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BADS_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BADS_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

