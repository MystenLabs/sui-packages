module 0x62593e66f7a446d1af17527dfcf13dd5bff0814dbb41534513b1e04112e58c34::steamm_lp_blols_bsui {
    struct STEAMM_LP_BLOLS_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BLOLS_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BLOLS_BSUI>(arg0, 9, b"STEAMM LP bLOLS-bSUI", b"STEAMM LP Token bLOLS-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BLOLS_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BLOLS_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

