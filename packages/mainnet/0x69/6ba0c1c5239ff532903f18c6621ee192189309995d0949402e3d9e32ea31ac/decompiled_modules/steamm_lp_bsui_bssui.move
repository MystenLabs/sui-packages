module 0x696ba0c1c5239ff532903f18c6621ee192189309995d0949402e3d9e32ea31ac::steamm_lp_bsui_bssui {
    struct STEAMM_LP_BSUI_BSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUI_BSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUI_BSSUI>(arg0, 9, b"STEAMM LP bSUI-bsSUI", b"STEAMM LP Token bSUI-bsSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUI_BSSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUI_BSSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

