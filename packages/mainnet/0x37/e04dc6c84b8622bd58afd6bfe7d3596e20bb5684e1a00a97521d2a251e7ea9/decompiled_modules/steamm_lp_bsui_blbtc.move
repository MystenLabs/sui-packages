module 0x37e04dc6c84b8622bd58afd6bfe7d3596e20bb5684e1a00a97521d2a251e7ea9::steamm_lp_bsui_blbtc {
    struct STEAMM_LP_BSUI_BLBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUI_BLBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUI_BLBTC>(arg0, 9, b"STEAMM LP bSUI-bLBTC", b"STEAMM LP Token bSUI-bLBTC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUI_BLBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUI_BLBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

