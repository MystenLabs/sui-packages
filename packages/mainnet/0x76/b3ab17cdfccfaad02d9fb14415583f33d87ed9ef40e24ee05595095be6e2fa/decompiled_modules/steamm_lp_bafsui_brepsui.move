module 0x76b3ab17cdfccfaad02d9fb14415583f33d87ed9ef40e24ee05595095be6e2fa::steamm_lp_bafsui_brepsui {
    struct STEAMM_LP_BAFSUI_BREPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BAFSUI_BREPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BAFSUI_BREPSUI>(arg0, 9, b"STEAMM LP bAFSUI-brepSUI", b"STEAMM LP Token bAFSUI-brepSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BAFSUI_BREPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BAFSUI_BREPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

