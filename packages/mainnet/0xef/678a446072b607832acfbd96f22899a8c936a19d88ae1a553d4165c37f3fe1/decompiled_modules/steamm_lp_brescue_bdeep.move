module 0xef678a446072b607832acfbd96f22899a8c936a19d88ae1a553d4165c37f3fe1::steamm_lp_brescue_bdeep {
    struct STEAMM_LP_BRESCUE_BDEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BRESCUE_BDEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BRESCUE_BDEEP>(arg0, 9, b"STEAMM LP bRESCUE-bDEEP", b"STEAMM LP Token bRESCUE-bDEEP", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BRESCUE_BDEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BRESCUE_BDEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

