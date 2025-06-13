module 0x4eb100f8da405f5490a72965a5dc3274bb20a934db4133e9787d606ec9b0b4fd::steamm_lp_busdc_bsuiagent {
    struct STEAMM_LP_BUSDC_BSUIAGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BUSDC_BSUIAGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BUSDC_BSUIAGENT>(arg0, 9, b"STEAMM LP bUSDC-bSUIAGENT", b"STEAMM LP Token bUSDC-bSUIAGENT", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BUSDC_BSUIAGENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BUSDC_BSUIAGENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

