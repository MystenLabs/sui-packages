module 0x9e16342af6d80ecdfab6c6f0c42572f1217b327cf3f59b8acdee4ae7673742b5::steamm_lp_bsui_busdt {
    struct STEAMM_LP_BSUI_BUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUI_BUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUI_BUSDT>(arg0, 9, b"STEAMM LP bSUI-bUSDT", b"STEAMM LP Token bSUI-bUSDT", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUI_BUSDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUI_BUSDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

