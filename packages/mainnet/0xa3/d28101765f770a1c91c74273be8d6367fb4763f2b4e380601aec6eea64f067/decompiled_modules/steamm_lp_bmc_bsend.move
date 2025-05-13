module 0xa3d28101765f770a1c91c74273be8d6367fb4763f2b4e380601aec6eea64f067::steamm_lp_bmc_bsend {
    struct STEAMM_LP_BMC_BSEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BMC_BSEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BMC_BSEND>(arg0, 9, b"STEAMM LP bMC-bSEND", b"STEAMM LP Token bMC-bSEND", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BMC_BSEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BMC_BSEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

