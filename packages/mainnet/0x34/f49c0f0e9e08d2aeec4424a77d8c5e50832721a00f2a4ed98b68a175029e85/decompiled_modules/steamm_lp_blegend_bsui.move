module 0x34f49c0f0e9e08d2aeec4424a77d8c5e50832721a00f2a4ed98b68a175029e85::steamm_lp_blegend_bsui {
    struct STEAMM_LP_BLEGEND_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BLEGEND_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BLEGEND_BSUI>(arg0, 9, b"STEAMM LP bLEGEND-bSUI", b"STEAMM LP Token bLEGEND-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BLEGEND_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BLEGEND_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

