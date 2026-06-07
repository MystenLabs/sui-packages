module 0x4b10b8d6ab8283dfbb52823f7ca834888ef4811faa7fe2d9d35a0d1a68fd9042::steamm_lp_bsui_bzpay {
    struct STEAMM_LP_BSUI_BZPAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUI_BZPAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUI_BZPAY>(arg0, 9, b"STEAMM LP bSUI-bZPAY", b"STEAMM LP Token bSUI-bZPAY", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUI_BZPAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUI_BZPAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

