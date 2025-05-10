module 0xc9fe6b58bf3552b53c4f42e426f67496e01e06c4f627b7c40501b8d253a8b710::steamm_lp_bteco_bsui {
    struct STEAMM_LP_BTECO_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BTECO_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BTECO_BSUI>(arg0, 9, b"STEAMM LP bTECO-bSUI", b"STEAMM LP Token bTECO-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BTECO_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BTECO_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

