module 0x8205d1eb815e89b5a24aba90d9bf826e02048efd00fdebf358cc9bceb6ee6fe3::steamm_lp_bsui_bkonasui {
    struct STEAMM_LP_BSUI_BKONASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BSUI_BKONASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BSUI_BKONASUI>(arg0, 9, b"STEAMM LP bSUI-bkonaSUI", b"STEAMM LP Token bSUI-bkonaSUI", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BSUI_BKONASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BSUI_BKONASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

