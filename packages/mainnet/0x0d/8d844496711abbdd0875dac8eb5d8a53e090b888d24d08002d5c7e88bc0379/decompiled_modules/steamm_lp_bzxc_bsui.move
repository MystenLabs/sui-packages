module 0xd8d844496711abbdd0875dac8eb5d8a53e090b888d24d08002d5c7e88bc0379::steamm_lp_bzxc_bsui {
    struct STEAMM_LP_BZXC_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BZXC_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BZXC_BSUI>(arg0, 9, b"STEAMM LP bZXC-bSUI", b"STEAMM LP Token bZXC-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BZXC_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BZXC_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

