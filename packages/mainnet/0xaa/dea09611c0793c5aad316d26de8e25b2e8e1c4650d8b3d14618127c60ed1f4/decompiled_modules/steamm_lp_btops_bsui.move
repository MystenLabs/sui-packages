module 0xaadea09611c0793c5aad316d26de8e25b2e8e1c4650d8b3d14618127c60ed1f4::steamm_lp_btops_bsui {
    struct STEAMM_LP_BTOPS_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BTOPS_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BTOPS_BSUI>(arg0, 9, b"STEAMM LP bTOPS-bSUI", b"STEAMM LP Token bTOPS-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BTOPS_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BTOPS_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

