module 0xd6c342de685c6bafe96e1ecd9e3b9ba73e59930b65de0e3c42d9eddcdb42519::steamm_lp_bsui_bmsend {
    struct STEAMM_LP_BSUI_BMSEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUI_BMSEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUI_BMSEND>(arg0, 9, b"STEAMM LP bSUI-bmSEND", b"STEAMM LP Token bSUI-bmSEND", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUI_BMSEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUI_BMSEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

