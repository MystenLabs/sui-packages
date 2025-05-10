module 0x495d60c5e8c0c0f1e0bce40ff2a0f8eeb2f8d93be598e40d6d29cef8d50395a0::steamm_lp_bcf_bisui {
    struct STEAMM_LP_BCF_BISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BCF_BISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BCF_BISUI>(arg0, 9, b"STEAMM LP bCF-biSUI", b"STEAMM LP Token bCF-biSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BCF_BISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BCF_BISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

