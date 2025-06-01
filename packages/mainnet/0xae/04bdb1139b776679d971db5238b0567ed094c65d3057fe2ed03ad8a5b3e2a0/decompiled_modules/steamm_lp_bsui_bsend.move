module 0xae04bdb1139b776679d971db5238b0567ed094c65d3057fe2ed03ad8a5b3e2a0::steamm_lp_bsui_bsend {
    struct STEAMM_LP_BSUI_BSEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUI_BSEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUI_BSEND>(arg0, 9, b"STEAMM LP bSUI-bSEND", b"STEAMM LP Token bSUI-bSEND", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUI_BSEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUI_BSEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

