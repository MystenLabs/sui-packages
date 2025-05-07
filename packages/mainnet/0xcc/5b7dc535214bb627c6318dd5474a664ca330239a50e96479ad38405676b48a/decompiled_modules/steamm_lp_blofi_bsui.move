module 0xcc5b7dc535214bb627c6318dd5474a664ca330239a50e96479ad38405676b48a::steamm_lp_blofi_bsui {
    struct STEAMM_LP_BLOFI_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BLOFI_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BLOFI_BSUI>(arg0, 9, b"STEAMM LP bLOFI-bSUI", b"STEAMM LP Token bLOFI-bSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BLOFI_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BLOFI_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

