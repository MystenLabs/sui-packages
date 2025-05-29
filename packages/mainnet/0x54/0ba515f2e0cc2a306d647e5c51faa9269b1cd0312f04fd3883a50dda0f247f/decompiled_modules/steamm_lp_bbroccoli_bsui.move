module 0x540ba515f2e0cc2a306d647e5c51faa9269b1cd0312f04fd3883a50dda0f247f::steamm_lp_bbroccoli_bsui {
    struct STEAMM_LP_BBROCCOLI_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BBROCCOLI_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BBROCCOLI_BSUI>(arg0, 9, b"STEAMM LP bBROCCOLI-bSUI", b"STEAMM LP Token bBROCCOLI-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BBROCCOLI_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BBROCCOLI_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

