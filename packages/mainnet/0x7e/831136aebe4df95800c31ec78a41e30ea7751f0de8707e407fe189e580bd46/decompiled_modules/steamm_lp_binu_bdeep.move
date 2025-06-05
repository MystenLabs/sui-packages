module 0x7e831136aebe4df95800c31ec78a41e30ea7751f0de8707e407fe189e580bd46::steamm_lp_binu_bdeep {
    struct STEAMM_LP_BINU_BDEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BINU_BDEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BINU_BDEEP>(arg0, 9, b"STEAMM LP bINU-bDEEP", b"STEAMM LP Token bINU-bDEEP", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BINU_BDEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BINU_BDEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

